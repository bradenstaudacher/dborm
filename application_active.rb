require "pry"
require "pg"
require "active_record"

require_relative 'contact_active'
require_relative "connection_active"

Connection.new

case

when ARGV[0] == nil

when ARGV[0] == "help"
  puts "Here is a list of available commands:
    \n new  - Create a new contact
    \n list - List all contacts
    \n find - Find a contact"

when ARGV[0] == "new"
  puts "Enter contact's first name"
  firstname = STDIN.gets.chomp
  puts "Enter contact's last name"
  lastname = STDIN.gets.chomp
  puts "Enter contact email"
  email = STDIN.gets.chomp
  new_contact = Contact.new
  new_contact.firstname = firstname
  new_contact.lastname = lastname
  new_contact.email = email
  new_contact.save
  
when ARGV[0] == "list"
  pp Contact.all
  puts "Total number of records #{Contact.all.count}"

when ARGV[0] == "find"
  puts "Enter search term:"
  term = STDIN.gets.chomp
  term = "%#{term}%"
  pp Contact.where("firstname LIKE :term OR lastname LIKE :term OR email LIKE :term", 
    {term: term})
end







