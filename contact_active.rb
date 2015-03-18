require "pry"
require "pg"
require_relative "connection_active"
require "active_record"

Connection.new
class Contact < ActiveRecord::Base
end
