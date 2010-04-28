require 'rubygems'
require 'rest_client'
require 'builder'
require 'crack'

require 'flixit/ext/hash'
require 'flixit/record'
require 'flixit/job'
require 'flixit/file_locations'
require 'flixit/file'
require 'flixit/parameters'
require 'flixit/response'
require 'flixit/exceptions'
require 'flixit/notification'

module Flixit
  
  VERSION = ::File.exist?('VERSION') ? ::File.read('VERSION') : ""
  
  CA_FILE = ::File.expand_path("flixit/pem_certificate/www.flixcloud.com.pem", ::File.dirname(__FILE__))
end