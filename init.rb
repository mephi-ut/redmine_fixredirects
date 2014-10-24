require 'redmine'

require_dependency "redmine_fixredirects/patches/app/controllers/attachments_controller"

Redmine::Plugin.register :redmine_fixredirects do
	name 'Redirects fixing plugin'
	author 'Dmitry Yu Okunev'
	author_url 'https://github.com/xaionaro/'
	description 'A plugin to fix redirects on Debian/sid Redmine3'
	url 'https://github.com/mephi-ut/redmine_fixredirects'
	version '0.0.1'
end
