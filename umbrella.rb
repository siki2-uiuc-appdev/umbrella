require "open-uri"
require "json"

40.times do 
  print "="
end
print "\n"
puts "  Will you need an umbrella today? "
40.times do 
  print "="
end
print "\n"
print "\n"

puts "Where are you?"

user_location = gets.chomp

# user_location = "200 S Wacker"


gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

# URI.open takes arg of string web address and returns <TempFile> object
# : If you call .read on an instance of Tempfile, it will return the contents of the file as a String.

raw_gmaps_data = URI.open(gmaps_api_url).read

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

first_result = results_array.at(0)

latitude = first_result.fetch("geometry").fetch("location").fetch("lat");

longitude = first_result.fetch("geometry").fetch("location").fetch("lng");

puts "Checking the weather in Chicago...."

puts "Your coordinates are #{latitude}, #{longitude}"

darksky_api_url = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/#{latitude},#{longitude}"

raw_darksky_data = URI.open(darksky_api_url).read

parsed_darksky_data = JSON.parse(raw_darksky_data)

current_temp = parsed_darksky_data.fetch("currently").fetch("temperature")

weather_summary = parsed_darksky_data.fetch("currently").fetch("summary")

puts "It is currently #{current_temp}°F and will be #{weather_summary.downcase} for the next hour"

hourly_data = parsed_darksky_data.fetch("hourly").fetch("data")

twelve_hour_data = []

# hourly_data.each do |hour|
#   i = 1
#   if i <= 12
#     twelve_hour_data.push(hour)
#     i += 1
#     p i
#   end
# end

for i in 0..11 do
  twelve_hour_data.push(hourly_data[i])
end

precip_probability = []


for i in 0...twelve_hour_data.length do
  precip_probability.push(twelve_hour_data[i].fetch("precipProbability"))
end

# p precip_probability

needUmbrella = false

precip_probability.each_with_index do |value, index|
  if precip_probability[index] > 0.10
    puts "In #{index} hours, there is a #{precip_probability[index]} chance of precipitation"
  else
   puts "You probably won't need an umbrella today."
   break
  end
  needUmbrella = true
end

if needUmbrella
  puts "You might want to take an umbrella!"
end

# p parsed_data.fetch("results").at(0).fetch("geometry").fetch("location")
