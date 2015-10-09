require 'json'
require 'csv'
require 'geocoder'
require 'geonames_api'
require 'open-uri'
require 'erb'
require 'json'

file = File.read('/Users/stephen/git/peddlerproj/october_geocoding/json_reports/hashAllRecords.json')

inputHash = JSON.parse(file)
outputHash = {:type => "FeatureCollection", :features => []}


inputHash.each do |key, value|

  currentFeature = {:type => "Feature", :properties => {:name => inputHash[key]["Title"], :author => inputHash[key]["Authors"],
                                                        :itemtype => inputHash[key]["itemtype"],
                                                        :date => inputHash[key]["date"],
                                                        :URI => inputHash[key]["extra"],
                                                  :locations => inputHash[key]["Locations"]},
              :geometry => {:type => "MultiPoint", :coordinates => []}}
  ## Above creates a temporary hash, the below will populate the :coordinates array within :geometry whenever lat/lon exist

  value.each do |elements, elementContents|
    if elements == "Locations"
      elementContents.each do |placename, geoProps| # Iterate through each object within larger "Locations" object
        unless geoProps.empty? # Only look at locations that have geo properties (and therefore received output from GeoNames API)
          lon = geoProps["lon"]
          lat = geoProps["lat"]
          coord = [lon, lat]
          currentFeature[:geometry][:coordinates] << coord # Pushes coordinates for a single location to "coordinates" array in :geometry hash
        end
      end
    end
  end
  outputHash[:features] << currentFeature # Push the temp feature object into the larger one, which contains all output
end

puts JSON.pretty_generate(outputHash)
