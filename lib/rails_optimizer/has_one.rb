module RailsOptimizer
	class HasOne < Association


		def self._define(owner, name )
			owner.__send__(:define_method, name) do |*args|
				return RailsOptimizer::HasOne.new(self, name, *args).get_target
			end
		end

		def get_target
			if args.empty?
				klass
			else
				klass.select(*args)
			end.execute(&reflection_scope).execute(&finded)
		end

		private

			def finded
				finder = {reflection.foreign_key.to_sym => owner.id}
				proc { send(:find_by, **finder) }
			end
	end

	define_method name.to_s do |*args|
				fk = self.class.foreign_key(name).to_sym
				if args.empty?
					name.to_s.classify.constantize.select("*").scoped(scope).find_by(fk => id)
				else
					name.to_s.classify.constantize.select(:id, *args).scoped(scope).find_by(fk => id)
				end
			end
end