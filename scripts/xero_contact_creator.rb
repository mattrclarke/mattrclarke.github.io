require "active_record"
require "action_view"
require "byebug"
require "oauth"
require "awesome_print"

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

class Student < Base
end

class Life < Base
end

  options = {
    site: "https://api.xero.com",
    request_token_path: "/oauth/RequestToken",
    access_token_path: "/oauth/AccessToken",
    authorize_path: "/oauth/Authorize",
    signature_method: "RSA-SHA1",
    private_key_file: "xero.pem"
  }

  key = "MQXS2LYXFB5I2S8I3CD66ES4CDLETR"
  secret = "ZCRJBCYZX402M73J0RIB13YY8O1XVZ"
  consumer = OAuth::Consumer.new(key, secret, options)
  @token = OAuth::AccessToken.new(consumer, key, secret)
#
#
#    lives = Life.find_by_sql("select lives.student_id, students.first_name, students.last_name, students.id,
#      students.email, students.xero_id from lives
#      inner join students on lives.student_id = students.id
#      where lives.status = 'ACT' ")

   lives = Life.where(status: 'ACT')
   ids = lives.map{|x| x.student_id}
   # Count is less for students than lives?
   students = Student.where(id: ids)
   log = []

puts lives.count
students.each do |student|
 endpoint = "https://api.xero.com/api.xro/2.0/contacts/?Email=#{student.email}"
    full_name = student.first_name + " " + student.last_name

    body = {
      "Name": full_name,
      "FirstName": student.first_name,
      "LastName": student.last_name,
      "EmailAddress": student.email,
      "Addresses": [{
        "AddressType": "POBOX",
        "AddressLine1": student.address,
        "City": student.suburb,
        "Country": "Australia",
        "PostalCode": student.postcode,
        "AttentionTo": "Corey Stinson"
      }],
      "Phones": [{
        "PhoneType": "DEFAULT",
        "PhoneNumber": student.mobile
      }]
    }

    response = @token.put(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
    xero_id = JSON.parse(response.body)["Id"]
    student.update!(xero_id: xero_id)
    puts response.code, response.body
    student.save
    puts student.inspect

    if response.code != '200'
    record = {
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email
      }
    log << record
  end

end
