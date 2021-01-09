module RailsOptimizer
	class Reflection
		attr_accessor :owner, :name, :foreign_key
		
		def initialize(owner, name)
			@owner = owner
			@name = name
		end

		def klass
			if reflection.polymorphic?
				owner.read_attribute(foreign_type).constantize
			else
				reflection.klass
			end
		end

		def scope
			reflection.scope
		end

		def reflection
			@reflection ||= owner._reflections[name]
		end

		def foreign_type
			reflection.foreign_type
		end

		def foreign_key
			reflection.foreign_key
		end
	end
end