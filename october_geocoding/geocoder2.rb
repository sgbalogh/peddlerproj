require 'json'
require 'csv'
require 'geocoder'
require 'geonames_api'

require 'open-uri'
require 'erb'
require 'json'

def degrees_to_meters(lng, lat)
  half_circumference = 20037508.34
  x = lng * half_circumference / 180
  y = Math.log(Math.tan((90 + lat) * Math::PI / 360)) / (Math::PI / 180)

  y = y * half_circumference / 180

  return [x, y]
end

records = {}
geometry = Array.new
singleValElements = Array.new
singleValElements = [0,1,2,3,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,36,37,38,39,40,41,42,43,44,45,46,53,54,55,56,57,58,59,60,184]

data = CSV.foreach('/Users/stephen/git/peddlerproj/october_geocoding/all_data_oct15.csv', {:headers => true, :header_converters => :symbol, :converters => :all}) do |line|

  records[line.fields[0]] = Hash.new

  records[line.fields[0]][:Locations] = Hash.new
  records[line.fields[0]][:Dates] = Hash.new
  records[line.fields[0]][:SubjectTerms] = []
  records[line.fields[0]][:Individuals] = []
  records[line.fields[0]][:Authors] = []
  records[line.fields[0]][:Editors] = []
  records[line.fields[0]][:PublicationPlace] = []


  #Places
  locCount = 1
  while (locCount <= 36) do

    if (line[107+locCount].to_s != '')
      currLoc = line[107+locCount]
      #records[line.fields[0]][:Placenames].push(currLoc)
      records[line.fields[0]][:Locations][currLoc] = Hash.new

    end
    locCount += 1
  end

  #Dates

      beginDate = line[178]
      records[line.fields[0]][:Dates]["begin"] = beginDate
  endDate = line[179]
  records[line.fields[0]][:Dates]["end"] = endDate



  #Subject terms
  locCount = 1
  while (locCount <= 10) do

    if (line[97+locCount].to_s != '')
      currLoc = line[97+locCount]
      records[line.fields[0]][:SubjectTerms].push(currLoc)
    end
    locCount += 1
  end

  #Editors
  locCount = 1
  while (locCount <= 5) do

    if (line[47+locCount].to_s != '')
      currLoc = line[47+locCount]
      records[line.fields[0]][:Editors].push(currLoc)
    end
    locCount += 1
  end

  #PublicationPlace
  locCount = 1
  while (locCount <= 3) do

    if (line[32+locCount].to_s != '')
      currLoc = line[32+locCount]
      records[line.fields[0]][:PublicationPlace].push(currLoc)
    end
    locCount += 1
  end

  #Title
  records[line.fields[0]][:Title] = line[10]

  #Individuals
  locCount = 1
  while (locCount <= 33) do

    if (line[143+locCount].to_s != '')
      currLoc = line[143+locCount]
      records[line.fields[0]][:Individuals].push(currLoc)
    end
    locCount += 1
  end

  #Authors
  locCount = 1
  while (locCount <= 6) do

    if (line[3+locCount].to_s != '')
      currLoc = line[3+locCount]
      records[line.fields[0]][:Authors].push(currLoc)
    end
    locCount += 1
  end

  #puts geometry.to_json
  #records[line.fields[10]][:newgeomo]
  #puts geometry.to_json

  # Creates individual value keys

  singleValElements.each do |x|
    unless line.fields[x].nil? || line.fields[x] == 0
    records[line.fields[0]][line.headers[x]] = line.fields[x]
    end


  end



end

records.each do |key, value|
  value.each do |key2, value2|
    if key2 == :Locations
      value2.each do |key3, value3|
        activePlace = key3
        query = ERB::Util.url_encode(activePlace)
        apiResponse = open("http://api.geonames.org/searchJSON?q=#{query}&maxRows=10&username=sgbalogh").read
        apiResponse = JSON.parse(apiResponse)
        if (apiResponse["totalResultsCount"] > 0)
          lat = apiResponse["geonames"][0]["lat"]
          lng = apiResponse["geonames"][0]["lng"]
          countryName = apiResponse["geonames"][0]["countryName"]
          population = apiResponse["geonames"][0]["population"]
          geonameId = apiResponse["geonames"][0]["geonameId"]
          fclName = apiResponse["geonames"][0]["fclName"]
          rdfLink = "http://sws.geonames.org/#{geonameId}/about.rdf"
          projected = degrees_to_meters(lng.to_f, lat.to_f)
          value2[key3].merge!(lat: lat.to_f)
          value2[key3].merge!(lon: lng.to_f)
          value2[key3].merge!(meters_x: projected[0])
          value2[key3].merge!(meters_y: projected[1])
          value2[key3].merge!(countryName: countryName)
          value2[key3].merge!(population: population)
          value2[key3].merge!(geonameId: geonameId)
          value2[key3].merge!(rdfLink: rdfLink)
          value2[key3].merge!(fclName: fclName)
          value2[key3].merge!(wktGeom: "POINT(#{projected[0]} #{projected[1]})")
        end
      end
    end
  end
end



puts JSON.pretty_generate(records)



