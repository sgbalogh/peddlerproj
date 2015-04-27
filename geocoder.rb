require 'csv'
require 'geocoder'
 
LOCATIONS = './rerun.csv'
 
def degrees_to_meters(lon, lat)
    half_circumference = 20037508.34
    x = lon * half_circumference / 180
    y = Math.log(Math.tan((90 + lat) * Math::PI / 360)) / (Math::PI / 180)
 
    y = y * half_circumference / 180
 
    return [x, y]
end
 
puts 'subid,jp_id,point,lat,lon,location,location_original'
CSV.foreach(LOCATIONS, :headers => true, :header_converters => :symbol) do |line|
    location = "#{line[:location]}"
    subid = "#{line[:subid]}"
    location_original = "#{line[:location_original]}"
    jp_id = "#{line[:jp_id]}"
    
    if location == ""
    	lat = 0
    	lon = 0
    else
    	result = Geocoder.search(location).first
    		if result == nil
    			lat = 0
    			lon = 0q
    		else
    			lat = result.latitude
    			lon = result.longitude
    		end
 end
    #point = "POINT(#{lon} #{lat})"
    projected = degrees_to_meters(lon, lat)
    point = "POINT(#{projected[0]} #{projected[1]})"
 	
    puts "#{subid},#{jp_id},#{point},#{lat},#{lon},\"#{location}\",\"#{location_original}\""
    sleep(0.25)
   
end