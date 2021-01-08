require "rails_optimizer/version"

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

		def self.scoped proc
			return proc.call if proc
			all
		end

		def self.finded obj, relation_name
			fk = foreign_key(obj, relation_name)
			find(obj.read_attribute(fk.to_sym)) unless obj.read_attribute(fk.to_sym).blank?
		end

		def self.foreign_key(obj, relation_name)
			obj.class.reflections[relation_name.to_s].foreign_key
		end

		def self.belongs_to(name, scope = nil, **options)
			super
			define_method name.to_s do |*args|
				super if args.empty?
				klass = if options[:polymorphic]
					read_attribute("#{name}_type".to_sym)
				else
					name.to_s
				end.classify.constantize.select(*args).scoped(scope).finded(self, name)
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
	end
end
