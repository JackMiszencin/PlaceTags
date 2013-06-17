class Tag < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :atlas
  has_many :reports, :foreign_key => "tag_id"
  has_many :events, :through => :reports
  belongs_to :size
  belongs_to :type
  has_many :roles, :foreign_key => :tag_id
  has_many :relatives, :through => :roles
  accepts_nested_attributes_for :size
  accepts_nested_attributes_for :type
  attr_accessible :size_attributes, :lng, :lat, :title, :size_id, :radius, :id, :type_id, :type_attributes
  after_save :maintain_type
  after_destroy :maintain_type
  validates :title, :presence => true

  def maintain_type
    t = self.type
    t.set_default_radius
    t.set_levels
  end

  def self.atlas(index)
    where(:atlas_id => index)
  end

  def recent_event_reports(x, event) #Gives number of reports for a specific event in last x hours.
    tminus = x.hours.ago
    count = 0
    event_reports = event_reports(event)
    event_reports.each do |r|
      if r.created_at > tminus
        count += 1
      end
    end
    return count
  end

  def event_reports(event)
    return event.reports.where(:tag_id => self.id)
  end

  def self.search(query_string, atlas_id)
    @results = Tag.atlas(atlas_id).includes(:relatives, :roles, :type)
    @find_me = query_string
    search_proc = Proc.new {
      |a, b|
      score_one = a.search_score(@find_me)
      score_two = b.search_score(@find_me)
      score_two <=> score_one
    }
    @results.select!{|r| r.search_score(@find_me) > 0}
    @results.sort!(&search_proc)
    return @results = @results[(0..4)]
  end
  def search_score(query_string)
    items = query_string.downcase.split(" ")
    score = 0.0
    if title.downcase == query_string
      score += 10
    elsif title.downcase.include?(query_string)
      score += 5
    else
    end
    items.each do |item|
      if title.downcase.include?(item)
        score += 1
      end
      roles.each do |role|
        r = role.relative
        if role.relative.title.downcase.include?(item)
          score += (role.relevance_score * 5)
        end
      end
      if type.label.downcase.include?(item)
        score += 2
      end
    end
    return score.round
  end
  # GEOMETRY METHODS
  def deg_per_met
    r = 6371000
    latrad = lat.abs * (2*Math::PI/360) # Converts latitudinal degrees into radians for the sake of sake of Ruby's sin function.
    rprime = r * Math.sin(latrad) # Using SOHCAHTOA to get the horizontal cross-sectional radius of the earth at the user's latitude.
    return 360 / (rprime*2*Math::PI) # Takes this radius and uses it to get the cross-sectional circumference at that point in meters
    # and return 360 degrees by this circumferences to get degrees per meter.
  end
  def include_point(latitude, longitude)
    deg_away = point_distance(latitude, longitude)
    if deg_away <= radius
      return true
    else
      return false
    end
  end
  def intersect(tag_two) # Determines if two tags intersect at all.
    if distance(tag_two) <= (radius + tag_two.radius)
      return true
    else
      return false
    end
  end
  def distance(tag_two) # Returns the distance of a latitude_longitude point from 
    # a tag. Returned in meters. Takes account for changes in meters per degree across
    # latitudes
    lat_dif = lat - tag_two.lat
    lng_dif = lng - tag_two.lng
    deg_square = lat_dif**2 + lng_dif**2
    avg_degrees_per_meter = (deg_per_met + tag_two.deg_per_met)/2
    return (Math.sqrt(deg_square))/avg_degrees_per_meter
  end
  def point_distance(latitude, longitude) # Returns the distance of a latitude_longitude point from 
    # a tag. Returned in meters. Does not take account for changes in meters per degree across
    # latitudes
    lat_dif = lat - latitude
    lng_dif = lng - longitude
    deg_square = lat_dif**2 + lng_dif**2
    return (Math.sqrt(deg_square))/deg_per_met
  end
  def segment_area(r, x) # Returns the area of a segment of a circle, where r is the 
    # radius and x is the distance between the circle's center and the chord which defines
    # the segment.
    half_chord = Math.sqrt(r**2 - x**2)
    triangle = half_chord * x
    sector = r**2 * Math.acos(x/r)
    return sector - triangle
  end
  def area
    return (radius**2)*Math::PI
  end
  def format_area
    if area > 1000.0
      line = number_with_delimiter((area/1000).round(2)) + " sq. km"
    else
      line = number_with_delimiter(area.round(2)) + " sq. m"
    end
    return line
  end
  def common_area(tag_two, type)
    case type
    when "duplicate"
      return area
    when "child"
      return tag_two.area
    when "parent"
      return area
    else
      away = distance(tag_two) # The distance between the first tag's
      # center and the second tag's center.
      r = radius
      r_two = tag_two.radius
      x = (away**2 - r_two**2 + r**2)/(2*away)
      x_two = away - x
      segment_one = segment_area(r, x)
      segment_two = segment_area(r_two, x_two)
      return segment_one + segment_two
    end
  end
  def format_common_area(tag_two, type)
    ca = common_area(tag_two, type)
    if ca > 1000.0
      line = number_with_delimiter((ca/1000).round(2)) + " sq. km"
    else
      line = number_with_delimiter(ca.round(2)) + " sq. m"
    end
    return line
  end


  # METHODS FOR CREATING SYSTEMS OF CONNECTION AND INTERITANCE
  def get_type(tag_two)
    if intersect(tag_two) == false
      type = "none"
    elsif radius == tag_two.radius && lat = tag_two.lat && lng == tag_two.lng
      type = "duplicate"
    elsif (distance(tag_two) + tag_two.radius) < radius
      type = "child"
    elsif (distance(tag_two) + radius) < tag_two.radius
      type = "parent"
    else
      type = "sibling"
    end
    return type
  end
  def build_connection(tag_two)
    return if id == tag_two.id
    type = get_type(tag_two)
    case type
    when "duplicate"
      build_duplicate(tag_two, 1)
    when "child"
      build_child(tag_two, 1)
    when "parent"
      build_parent(tag_two, 1)
    when "sibling"
      build_sibling(tag_two, 1)
    else
      return
    end
  end
  def build_duplicate(tag_two, iteration)
    rel = relevance(tag_two, "duplicate")
    r = Role.new
    r.kind = "duplicate"
    r.relevance_score = rel
    r.tag_id = id
    r.relative_id = tag_two.id
    r.save
    if iteration == 1
      tag_two.build_duplicate(self, 2)
    else
      return
    end
  end

  def build_child(tag_two, iteration)
    rel = relevance(tag_two, "child")
    r = Role.new
    r.kind = "child"
    r.relevance_score = rel
    r.tag_id = id
    r.relative_id = tag_two.id
    r.save
#    c = Connection.new
#    c.type = "child"
#    c.tag = self
#    c.relative = tag_two
#    c.relevance = rel
#    c.save
    if iteration == 1
      tag_two.build_parent(self, 2)
    else
      return
    end
  end
  def build_parent(tag_two, iteration)
    rel = relevance(tag_two, "parent")
    r = Role.new
    r.kind = "parent"
    r.relevance_score = rel
    r.tag_id = id
    r.relative_id = tag_two.id
    r.save
#    c = Connection.new
#    c.type = "parent"
#    c.tag = self
#    c.relative = tag_two
#    c.relevance = rel
#    c.save
    if iteration == 1
      tag_two.build_child(self, 2)
    else
      return
    end
  end
  def build_sibling(tag_two, iteration)
    rel = relevance(tag_two, "sibling")
    r = Role.new
    r.kind = "sibling"
    r.relevance_score = rel
    r.tag_id = id
    r.relative_id = tag_two.id
    r.save
#    c = Connection.new
#    c.type = sibling
#    c.tag = self
#    c.relative = tag_two
#    c.relevance = rel
#    c.save
    if iteration == 1
      tag_two.build_sibling(self, 2)
    else
      return
    end
  end
  def relevance(tag_two, type)
    share = common_area(tag_two, type)
    score = (share**2)/(area * tag_two.area)
    return score
  end

end
