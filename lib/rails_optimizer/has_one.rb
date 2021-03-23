module RailsOptimizer
	class HasOne < Association


		def self._define(owner, name )
			owner.__send__(:define_method, name) do |*args|
				return RailsOptimizer::HasOne.new(self, name, *args).get_target
			end
		end

		def get_target
			super do
				if args.empty?
					klass
				else
					klass.select(*args)
				end.execute(&reflection_scope).execute(&finded)
			end
		end

		private

			def finded
				finder = {reflection.foreign_key.to_sym => owner.id}
				proc { send(:find_by, **finder) }
			end
	end

end