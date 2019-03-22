require "active_record"
require "action_view"
require "httparty"
require "byebug"

class Base < ActiveRecord::Base

  establish_connection(
    adapter: "mysql2",
    host: "127.0.0.1",
    username: "root",
    password: "password",
    database: "workskills"
  )
  self.abstract_class = true
end

class Business < Base
end

class Student < Base
end

# This will create a text file with all the results that are missing place ids

def record_invalid(result)
  open('output.txt', 'w') do |f|
    result.each do |x|
      x.each do |k, v|
        f.puts "#{k}: #{v}\n"
      end
      f.puts "-" * 100
    end
  end
end

students = Student.where.not(place_id: nil)
businesses = Business.where.not(place_id: nil)
key = "AIzaSyClvXJEXeSCdhcsHBQPkdYpcu3VTQSfBOs"
byebug
invalid_records = []

students.each do |student|
  endpoint = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{student[:place_id]}&key=#{key}"

  response = HTTParty.get(endpoint)
  begin
    lat = response["result"]["geometry"]["location"]["lat"]
    long = response["result"]["geometry"]["location"]["lng"]
  rescue
    record = {
      id: student.id,
      place_id: student.place_id,
      address: student.address,
      suburb: student.suburb,
      postcode: student.postcode,
      state: student.state
      }
    invalid_records << record
  end
  p "student: #{student.id}"
  student.update!(latitude: lat, longitude: long)
  student.save
  puts student.inspect
  sleep 0.11
end

businesses.each do |business|
  endpoint = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{business[:place_id]}&key=#{key}"

  response = HTTParty.get(endpoint)

  begin
    lat = response["result"]["geometry"]["location"]["lat"]
    long = response["result"]["geometry"]["location"]["lng"]
  rescue
    record = {
      id: business.id,
      place_id: business.place_id,
      address: business.address,
      suburb: business.suburb,
      postcode: business.postcode,
      state: business.state
    }
    invalid_records << record
  end
  p "Business: #{business.id}"
  business.update!(latitude: lat, longitude: long)
  business.save
  sleep 0.11
end

record_invalid(invalid_records)
