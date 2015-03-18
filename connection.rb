require 'csv'
require 'pry'

class Connection
  attr_accessor :line
  def initialize(dbname, user, host, password, port)
    @dbname = dbname
    @user = user
    @host = host
    @password = password
    @port = port
    @line = PG.connect(
      dbname: @dbname,
      port: @port,
      user: @user,
      host: @host,
      password: @password
      )
  end
  class << self
    def start
      if is_csv_empty?
        get_details
      else
        read_from_csv
      end
    end
  end
end


def get_details
  puts "Please enter database name:"
  dbname = gets.chomp
  puts "Please enter user:"
  user = gets.chomp
  puts "Please enter host:"
  host = gets.chomp
  puts "Please enter password:"
  password = gets.chomp
  puts "Please enter port:"
  port = gets.chomp.to_i
  write_to_csv(dbname, user, host, password, port)
  Connection.new(dbname, user, host, password, port)
end

def is_csv_empty?
  file = CSV.open("connection.csv", "r")
  array_of_info = []
  file.each do |row|
    array_of_info << row
  end
  if array_of_info == []
    return true
  else
    return false
  end
end

def read_from_csv
  file = CSV.open("connection.csv", "r")
  array_of_info = []
  file.each do |row|
    array_of_info << row
  end
  array_of_info = array_of_info[0]
   Connection.new(array_of_info[0], array_of_info[1], array_of_info[2], array_of_info[3], array_of_info[4].to_i)
end


# def write_to_csv
#   file = CSV.open("connection.csv", "w")
#   file.each do |csv|
#     do |info|
#       csv << info
#     end
#   end
# end
