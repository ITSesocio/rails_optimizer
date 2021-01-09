module RailsOptimizer
	class BelongsTo
		attr_accessor :klass, :name, :args, :reflection, :owner

		def initialize(owner, name, *args)
			@owner = owner
			@name  = name.to_s
			@args  = *args
		end

		def self._define(owner, name )
			owner.__send__(:define_method, name) do |*args|
				return RailsOptimizer::BelongsTo.new(self, name, *args).get_target
			end
		end

		def get_target
			if args.empty?
				klass
			else
				klass.select(*args)
			end
				.execute{reflection_scope}
				.execute{ |obj| finded(obj)}
		end

		private
			def reflection
				@reflection ||= RailsOptimizer::Reflection.new(owner, name)
			end

			def klass
				reflection.klass
			end

			def reflection_scope
				reflection.scope
			end

			def finded(obj)
				obj.find( owner.read_attribute(foreign_key) )
			end

			def foreign_key
				reflection.foreign_key.to_sym
			end

	end
end