require 'mongoid'
require 'mongoid-simple-userstamps'

Mongoid.load!('spec/support/mongoid.yml', :test)

Mongoid.logger.level = Logger::ERROR
Mongo::Logger.logger.level = Logger::ERROR
