require 'application_helper'
require 'uri'

module FixRedirects
	module ApplicationHelperPatch
		def self.included(base)
			base.extend(ClassMethods)
			base.send(:include, InstanceMethods)

			base.class_eval do
				alias_method_chain :context_menu, :fixredirects
			end
		end

		module ClassMethods
		end

		module InstanceMethods
			def context_menu_with_fixredirects(url)
				url_parts = url.split("?")
				return context_menu_without_fixredirects("#{url_parts[0]}?next=#{URI.encode(back_url, /\W/)}#{url_parts[1].nil? ? "" : "&#{url_parts[1]}"}")
			end
		end
	end
end
ApplicationHelper.send(:include, FixRedirects::ApplicationHelperPatch)

