require 'breakup/version'

require 'compass'
extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('breakup', :path => extension_path)
