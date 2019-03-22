module Lib
  class Xero

    require "json"
    require "oauth"
    require "builder"
    require "byebug"
    class Error < StandardError; end

    def initialize
      options = {
        site: "https://api.xero.com",
        request_token_path: "/oauth/RequestToken",
        access_token_path: "/oauth/AccessToken",
        authorize_path: "/oauth/Authorize",
        signature_method: "RSA-SHA1",
        private_key_file: "#{Rails.root}/config/xero.pem"
      }

      consumer = OAuth::Consumer.new(ENV["XERO_KEY"], ENV["XERO_SECRET"], options)
      @token = OAuth::AccessToken.new(consumer, ENV["XERO_KEY"], ENV["XERO_SECRET"])
    end

#----------------------------------contacts CRUD--------------------------------

    #----------------CREATE A STUDENT XERO CONTACT------------------

    def create_student_contact(student)
      endpoint = "https://api.xero.com/api.xro/2.0/Contacts/"
      first_name = student.first_name
      last_name = student.last_name
      full_name = first_name + " " + last_name
      address = student.address + " " + student.suburb
      body = {
        "Name": full_name,
        "FirstName": first_name,
        "LastName": last_name,
        "EmailAddress": student.email,
        "Addresses": [{
          "AddressType": "POBOX",
          "AddressLine1": student.address,
          "City": "Queensland",
          "Country": student.country,
          "PostalCode": student.postcode,
          "AttentionTo": "Corey Stinson"
        }],
        "Phones": [{
          "PhoneType": "DEFAULT",
          "PhoneNumber": student.mobile
        }]
      }
      response = @token.put(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
      student.update(xero_id: JSON.parse(response.body)["Contacts"][0]["ContactID"])
    end

    #----------------UPDATE A STUDENT CONTACT---------------------

    # def update_contact(*parameters)
    # end

    def update_student_contact(contact_id)
      endpoint = "https://api.xero.com/api.xro/2.0/Contacts/#{contact_id}"
      first_name = student.first_name
      last_name = student.last_name
      full_name = first_name + " " + last_name

      body = {
        "Name": full_name,
        "FirstName": first_name,
        "LastName": last_name,
        "EmailAddress": student.email,
        "Addresses": [{
          "AddressType": "Home",
          "AddressLine1": student.address,
          "City": "Brisbane",
          "Country": student.country,
          "PostalCode": student.postcode,
          "AttentionTo": "Corey Stinson"
        }],
        "Phones": [{
          "PhoneType": "DEFAULT",
          "PhoneNumber": student.mobile
        }]
      }
      response = @token.post(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
    end

    #------------------CREATE A BUSINESS CONTACT---------------------

    def create_contact(body)
        endpoint = "https://api.xero.com/api.xro/2.0/Contacts/#{body[:contactID]}"
        response = @token.post(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
      business.update(xero_id: xero_id)
    end

    #------------------UPDATE A BUSINESS CONTACT---------------------

    def update_contact(body)
      endpoint = "https://api.xero.com/api.xro/2.0/Contacts/#{body[:contactID]}"
      response = @token.post(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
    end

    #----------------GET CONTACT DETAILS FROM XERO------------------

    def get_contact(contact_id)
      endpoint = "https://api.xero.com/api.xro/2.0/contacts/#{contact_id}"
      response = @token.get(endpoint, { "Accept": "application/json" })
      if response.code != "200"
        raise Error, response.body
      end

      parsed = JSON.parse(response.body)
      contact = parsed["Contacts"][0]
      return contact
    end


#---------------------------------invoicing-------------------------------------

#---------------------------CREATE AN INVOICE------------------------

    def create_invoice(contact_id)
      endpoint = "https://api.xero.com/api.xro/2.0/Invoices/#{contact_id}"
      body =
      {
        "Type": "ACCREC",
        "Contact": {
          "ContactID": contact_id
        },
        "DueDate": "\/Date(1518685950940+0000)\/",
        "LineItems": [
          {
            "Description": "Services as agreed",
            "Quantity": "4",
            "UnitAmount": "100.00",
            "AccountCode": "200"
          }
        ],
        "Status": "AUTHORISED"
        }
      response = @token.put(endpoint, { json: JSON.dump(body) }, { "Accept": "application/json" })
      if response.code == "400"
        raise Error, JSON.parse(response.body)["Elements"][0]["ValidationErrors"]
      end

    end

    #----------------GET AN INVOICE FROM INVOICE ID------------------

    def get_invoice(invoice_id)
      # Gets a single invoice from an invoice id,
      endpoint = "https://api.xero.com/api.xro/2.0/Invoices/#{invoice_id}"
      response = @token.get(endpoint, { "Accept": "application/json" })

      if response.code != "200"
        raise Error, JSON.parse(response.body)
      end

      parsed = JSON.parse(response.body)

    end

    #----------------GET ALL INVOICES FOR A CONTACT ID------------------

        def get_invoices(contact_id)
          # Gets all the invoices for a contact id
          query = URI.encode("Contact.ContactId=GUID(\"#{contact_id}\")", /\W/)
          endpoint = "https://api.xero.com/api.xro/2.0/invoices?where=#{query}"

          response = @token.get(endpoint, { "Accept": "application/json" })

          if response.code != "200"
            raise Error, JSON.parse(response.body)
          end
          invoices = JSON.parse(response.body)["Invoices"]
          return invoices
        end

    #----------------GET A SINGLE INVOICE FOR DOWNLOADING------------------

        def get_invoice(invoice_id)
          endpoint    = "https://api.xero.com/api.xro/2.0/Invoices/#{invoice_id}"
          response = @token.get(endpoint, { "Accept": "application/pdf" })

          if response.code != "200"
            raise Error, JSON.parse(response.body)
          end
          encoded = Base64.encode64(response.body)
          return encoded
        end

#---------------------------------validation------------------------------------

    #----------MATCH A WOLAS RECORD TO XERO RECORD ON BUSINESS-------------

    def match_business(business, xero_id)
      query = URI.encode("ContactId=GUID(\"#{xero_id}\")", /\W/)
      endpoint = "https://api.xero.com/api.xro/2.0/contacts?where=#{query}"

      response = @token.get(endpoint, { "Accept": "application/json" })
      puts '-' * 50
      puts response.code
      puts '-' * 50
      if response.code != '200'
        return false
      end
      byebug
      parsed = JSON.parse(response.body)["Contacts"][0]

      if parsed["Name"] != business.trading
        return false
      end

    # Return true if the two emails match, or are both empty ('' and nil)

      email = business.email
      xero_email = parsed["EmailAddress"]

      if email == xero_email || email == nil && xero_email == ''
        return true
      end

      return false
    end

    #----------MATCH A WOLAS RECORD TO XERO RECORD ON STUDENT-------------

    def match_student(student, xero_id)
      query = URI.encode("ContactId=GUID(\"#{xero_id}\")", /\W/)
      endpoint = "https://api.xero.com/api.xro/2.0/contacts?where=#{query}"
      response = @token.get(endpoint, { "Accept": "application/json" })

      if response.code == '400'
        return false
      end

      parsed = JSON.parse(response.body)["Contacts"][0]
      if parsed["FirstName"] != student.first_name || parsed["LastName"] != student.last_name
        return false
      end

      email = student.email
      xero_email = parsed["EmailAddress"]

      if email == xero_email || email == nil && xero_email == ''
        return true
      end

      return false
    end

  end
end
