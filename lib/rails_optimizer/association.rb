module RailsOptimizer
	class Association
		attr_accessor :klass, :name, :args, :reflection, :owner

		def initialize(owner, name, *args)
			@owner = owner
			@name  = name.to_s
			@args  = *args
		end

		def reflection
			@reflection ||= RailsOptimizer::Reflection.new(owner, name)
		end

		def klass
			reflection.klass
		end

		def reflection_scope
			reflection.scope
		end
	end
end