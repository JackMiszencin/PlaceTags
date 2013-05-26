class Tag < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :atlas
  has_many :reports, :foreign_key => "tag_id"
  belongs_to :size
  has_many :roles, :foreign_key => :tag_id
  has_many :relatives, :through => :roles
  accepts_nested_attributes_for :size
  attr_accessible :size_attributes, :lng, :lat, :title, :size_id, :radius, :id
  # attr_accessible :title, :body
  def self.atlas(index)
    where(:atlas_id => index)
  end

  # GEOMETRY METHODS
  def deg_per_met
    r = 6371000
    latrad = lat.abs * (2*Math::PI/360) # Converts latitudinal degrees into radians for the sake of sake of Ruby's sin function.
    rprime = r * Math.sin(latrad) # Using SOHCAHTOA to get the horizontal cross-sectional radius of the earth at the user's latitude.
    return 360 / (rprime*2*Math::PI) # Takes this radius and uses it to get the cross-sectional circumference at that point in meters
    # and return 360 degrees by this circumferences to get degrees per meter.
  end
  def include_point(latit, longit)
    deg_away = distance(latit, longit)
    if deg_away <= radius
      return true
    else
      return false
    end
  end
  def intersect(tag_two) # Determines if two tags intersect at all.
    if distance(tag_two.lat, tag_two.lng) <= (radius + tag_two.radius)
      return true
    else
      return false
    end
  end
  def distance(latit, longit) # Returns the distance of a latitude_longitude point from 
    # a tag. Returned in meters.
    lat_dif = lat - latit
    lng_dif = lng - longit
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
      away = distance(tag_two.lat, tag_two.lng) # The distance between the first tag's
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
    elsif (distance(tag_two.lat, tag_two.lng) + tag_two.radius) < radius
      type = "child"
    elsif (distance(tag_two.lat, tag_two.lng) + radius) < tag_two.radius
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
