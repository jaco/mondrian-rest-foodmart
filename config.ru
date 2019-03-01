
require 'jbundler'
require 'jdbc/mysql'
Jdbc::MySQL.load_driver


require 'rack/config'
require 'rack/cors'
require 'logger'
require 'mondrian_rest'


logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

JDBC_URL = ENV["JDBC_URL"] || 'mysql://127.0.0.1:3308/pentaho'
JDBC_USERNAME = ENV["JDBC_USERNAME"] || 'root'
JDBC_PASSWORD = ENV["JDBC_PASSWORD"] || 'root'

PARAMS =   {
  driver: 'jdbc',
  jdbc_driver: 'com.mysql.jdbc.Driver',
  jdbc_url: "jdbc:" + JDBC_URL,
  username: JDBC_USERNAME,
  password: JDBC_PASSWORD,
  catalog: File.join(File.dirname(__FILE__), 'schema.xml')
}

use Rack::Config do |env|
  env['mondrian-olap.params'] = PARAMS
end

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end



run Mondrian::REST::Api
