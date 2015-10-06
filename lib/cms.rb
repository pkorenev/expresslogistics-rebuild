require 'cms/globalize_extensions'
require 'cms/url_methods'
require "cms/meta_tags"
require 'cms/sitemap_element'
require 'cms/html_block'
require 'cms/active_record_extensions'
require 'cms/page'
require 'cms/dynamic_router'

require 'cms/action_controller_extension'

require 'cms/articles'



module Cms
  class << self
    def load_routes
      Cms::DynamicRouter.load
    end

    def configure_page_models
      RailsAdmin::Config.included_models += [Cms::HtmlBlock, Cms::HtmlBlock::Translation, Cms::MetaTags, Cms::MetaTags.translation_class]

      RailsAdmin.config Cms::HtmlBlock do
        field :translations, :globalize_tabs
      end

      RailsAdmin.config Cms::HtmlBlock::Translation do
        field :locale, :hidden
        field :content, :ck_editor
      end

      self.page_models.each do |m|
        m.configure_page_model
      end


    end

    def page_models(options = {})
      load_pages_from_pages_directory = options.delete :load_pages_from_pages_directory
      load_pages_from_pages_directory = true if load_pages_from_pages_directory.nil?

      static_page_classes = []

      if load_pages_from_pages_directory
        page_names = Dir[Rails.root.join("app/models/pages/*.rb")].map{|filename|  File.basename(filename, ".*"); }

        static_page_classes = page_names.map{|page_name| "Pages::#{page_name.underscore.classify}".constantize }
      end

      pages = begin; Cms::Page.all ;rescue []; end
      db_page_classes = pages.map(&:class).uniq rescue []
      page_classes = (static_page_classes + db_page_classes).uniq

      return page_classes
    end

    def get_block(&block)
      return block
    end

    def label(name)
      return name
    end


  end
end