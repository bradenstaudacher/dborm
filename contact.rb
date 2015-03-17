require "pry"
require "pg"
require_relative "connection"

# CONN = PG.connect(
#   dbname: 'd2hpm89qtdv47d',
#   port: 5432,
#   user: 'bkjrkznvzprjwp',
#   host: 'ec2-50-19-249-214.compute-1.amazonaws.com',
#   password: 'PqquHIEvJIDgLAakmsYPEWURmF'
#   )

con = Connection.start
CONN = con.line

class Contact
 
  attr_accessor :firstname, :lastname, :email
  attr_reader :id
 
  def initialize(firstname, lastname, email, id=nil)
    # TODO: assign local variables to instance variables
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end

  def is_nil?
    @id.nil?
  end


  def save
    if is_nil?
      result = CONN.exec_params('INSERT INTO contacts(firstname, lastname, email)
        VALUES($1, $2, $3) RETURNING id', [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3
      WHERE id = $4', [@firstname, @lastname, @email, @id])
    end
  end

  # def delete
  #   CONN.exec_params('DELETE FROM contacts
  #     WHERE id = $1', [@id])
  # end
 
  ## Class Methods
  class << self

    def delete(id)
      contact_to_delete = Contact.find(id)
      if contact_to_delete != nil
        puts "Are you sure you want to delete?
        #{contact_to_delete["firstname"]} #{contact_to_delete["lastname"]}
        #{contact_to_delete["email"]} (y/n)"
        case gets.chomp
          when "y"
            CONN.exec_params('DELETE FROM contacts WHERE id = $1', [id])
          else
            puts "Contact not deleted"
        end
      else
        puts "Invalid Contact ID"
      end
    end
    
    def find(id)
      find = CONN.exec_params('SELECT id, firstname, lastname, email 
        FROM contacts WHERE id = $1 LIMIT 1', [id])
      if find.ntuples != 0
        find[0]
      else
        nil
      end
    end

    def find_by_firstname(firstname)
       find = CONN.exec_params('SELECT id, firstname, lastname, email 
        FROM contacts WHERE firstname = $1', [firstname])
      if find.ntuples != 0
        contact_list = []
        find.each do |contact|
          contact_list << contact
        end
        return contact_list
      else
        nil
      end
    end

    def find_by_lastname(lastname)
       find = CONN.exec_params('SELECT id, firstname, lastname, email 
        FROM contacts WHERE lastname = $1', [lastname])
      if find.ntuples != 0
        contact_list = []
        find.each do |contact|
          contact_list << contact
        end
        return contact_list
      else
        nil
      end
    end

    def find_by_email(email)
        find = CONN.exec_params('SELECT id, firstname, lastname, email 
        FROM contacts WHERE email = $1', [email])
      if find.ntuples != 0
        contact_list = []
        find.each do |contact|
          contact_list << contact
        end
        return contact_list
      else
        nil
      end
    end

  end
end

binding.pry

