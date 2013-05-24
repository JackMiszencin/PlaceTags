class Tag < ActiveRecord::Base
	belongs_to :atlas
	has_many :reports, :foreign_key => "tag_id"
	belongs_to :size
	accepts_nested_attributes_for :size
	attr_accessible :size_attributes, :lng, :lat, :title, :size_id, :radius
  # attr_accessible :title, :body
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
  def distance(latit, longit) # Returns the distance of a latitude_longitude point from 
  	# a tag. Returned in meters.
  	lat_dif = lat - latit
  	lng_dif = lng - longit
  	deg_square = lat_dif**2 + lng_dif**2
  	return (Math.sqrt(deg_square))/deg_per_met
  end
  def common_area(tag_two)
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

end
