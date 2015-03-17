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
      Connection.new(dbname, user, host, password, port)
    end
  end
end