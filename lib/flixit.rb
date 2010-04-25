require 'rubygems'
require 'httpclient'
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
  VERSION = File.exist?('VERSION') ? File.read('VERSION') : ""
end