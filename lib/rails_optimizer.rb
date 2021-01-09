require "rails_optimizer/version"
require "rails_optimizer/belongs_to"
require "rails_optimizer/reflection"

module RailsOptimizer
  class Error < StandardError; end
  extend ActiveSupport::Concern

  included do
		def save
			if has_changes_to_save?
				super
			else
				true
			end
		end

		def self.has_one(name, scope = nil, **options)
			super
			define_method name.to_s do |*args|
				fk = self.class.foreign_key(name).to_sym
				if args.empty?
					name.to_s.classify.constantize.select("*").scoped(scope).find_by(fk => id)
				else
					name.to_s.classify.constantize.select(:id, *args).scoped(scope).find_by(fk => id)
				end
			end
		end

		def self.belongs_to(name, scope = nil, **options)
			super
			RailsOptimizer::BelongsTo._define(self, name)
		end

		def self.execute(&block)
			block.call(self) || all 
		end
	  	
	end
end
