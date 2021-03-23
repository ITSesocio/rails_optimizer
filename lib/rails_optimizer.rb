require "rails_optimizer/version"
require "rails_optimizer/association"
require "rails_optimizer/belongs_to"
require "rails_optimizer/has_one"
require "rails_optimizer/reflection"

module RailsOptimizer
  class Error < StandardError; end
  extend ActiveSupport::Concern

  included do
		def save(args=nil)
			if has_changes_to_save?
				super(args)
			else
				true
			end
		end

		def self.has_one(name, scope = nil, **options)
			super
			RailsOptimizer::HasOne._define(self,name)
		end

		def self.belongs_to(name, scope = nil, **options)
			super
			RailsOptimizer::BelongsTo._define(self, name)
		end

		def self.execute(&method)
			return all unless block_given?
			class_eval(&method)
		end
	  	
	end
end
