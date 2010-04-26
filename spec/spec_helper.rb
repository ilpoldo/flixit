$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'flixit'
require 'spec'
require 'spec/autorun'
require 'fredo'

Spec::Runner.configure do |config|
  
end
