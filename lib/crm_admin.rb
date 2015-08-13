module CrmAdmin
  class << self
    def config entity, &block
      write = false
      if block_given?
        write = true
      end

      config = nil

      if entity.nil?
        config = CrmAdmin::Config
      else
        config = CrmAdmin::Config.model(entity)
      end

      if !write
        return config
      end
    end
  end
end

# CrmAdmin.config do |config|
#   include_models [Article, Service]
#   exclude_models []
#
#   model Article do
#     visible false
#     configure :content, :additional_content, as: :ckeditor do
#       theme :dark
#     end
#   end
# end
#
#
#
#


