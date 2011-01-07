require 'rubygems'
require 'utility_belt'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] = [] unless IRB.conf.key?(:LOAD_MODULES)

class Object
	def local_methods
		(methods - Object.instance_methods).sort
	end
end 

puts 'Loaded ~/.irbrc'
