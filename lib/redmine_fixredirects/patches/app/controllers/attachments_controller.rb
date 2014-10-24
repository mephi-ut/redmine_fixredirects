module FixRedirects
	module AttachmentsControllerPatch
		def self.included(base)
			base.extend(ClassMethods)
			base.send(:include, InstanceMethods)

			base.class_eval do
				alias_method_chain :destroy, :fixredirects
			end
		end

		module ClassMethods
		end

		module InstanceMethods
			def destroy_with_fixredirects
				if @attachment.container.respond_to?(:init_journal)
					@attachment.container.init_journal(User.current)
				end
				if @attachment.container
					# Make sure association callbacks are called
					@attachment.container.attachments.delete(@attachment)
				else
					@attachment.destroy
				end

				respond_to do |format|
					format.html {
						unless params[:next].nil?
							redirect_to params[:next]
						else
							redirect_to_referer_or project_path(@project)
						end
					}
					format.js
				end
			end
		end
	end
end

AttachmentsController.send(:include, FixRedirects::AttachmentsControllerPatch)

