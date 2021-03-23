module RailsOptimizer
	class BelongsTo < Association

		def self._define(owner, name )
			owner.__send__(:define_method, name) do |*args|
				return RailsOptimizer::BelongsTo.new(self, name, *args).get_target
			end
		end

		def get_target
			super do
				if args.empty?
					klass
				else
					klass.select(*args)
				end
					.execute(&reflection_scope)
					.execute(&finded)
			end
		end

		private
			
			def finded
				id = owner.read_attribute(foreign_key)
				proc { send(:find_by, {id: id}) }
			end

			def foreign_key
				reflection.foreign_key.to_sym
			end

	end
end