require "open-uri"
require "json"


p "Where are you?"

user_location = gets.chomp

# user_location = "200 S Wacker"

p user_location

gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

# URI.open takes arg of string web address and returns <TempFile> object
# : If you call .read on an instance of Tempfile, it will return the contents of the file as a String.

raw_gmaps_data = URI.open(gmaps_api_url).read

address_data = JSON.parse(raw_gmaps_data)

p address_data
