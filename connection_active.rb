class Connection
  def initialize
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    encoding: 'unicode',
    pool: 5,
    database: 'd2hpm89qtdv47d',
    username: 'bkjrkznvzprjwp',
    password: 'PqquHIEvJIDgLAakmsYPEWURmF',
    host: 'ec2-50-19-249-214.compute-1.amazonaws.com',
    port: 5432,
    min_messages: 'error'
    )
  end
end