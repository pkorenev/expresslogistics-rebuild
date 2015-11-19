module Cms
  module Articles
    module ActiveRecordBaseExtension
      module ClassMethods
        def articles_table_name
          self.name.underscore.gsub("/", "_").pluralize
        end

        def create_articles_table

          connection.create_table articles_table_name do |t|
            t.boolean :published
            t.string :name
            t.string :url_fragment
            t.text :description
            t.text :content
            t.has_attached_file :avatar
            t.datetime :released_at


            t.timestamps null: false
          end

          create_translation_table!(name: :string, url_fragment: :string, description: :text, content: :text)
        end

        def drop_articles_table
          connection.drop_table articles_table_name

          drop_translation_table!
        end

        def acts_as_article(options)

          has_seo_tags
          has_sitemap_record
          if options[:avatar] != false
            has_attached_file :avatar, (options[:avatar] || {})
            validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
            attr_accessible :avatar
          end

          scope :published, -> { where(published: true) }
          scope :default_order, -> { order("id desc") }

          translates :name, :url_fragment, :description, :content
          accepts_nested_attributes_for :translations
          attr_accessible :translations, :translations_attributes

          enable_globalize_getters

          self.include Cms::ArticleMethods::InstanceMethods

          self.before_save :initialize_released_at

          self.class_eval "class Translation; attr_accessible *attribute_names; include Cms::UrlMethods; before_save :auto_build_url_fragment ; end;"
        end

        def models *args, &block
          args.each do |m|
            RailsAdmin.config m, &block
          end
        end

        def configure_article_model
          RailsAdmin.config.included_models += [self, self.translation_class]

          model = self


          # [model, model.translation_class].each do |m|
          #   RailsAdmin.config m do
          #     visible false
          #     is_translation_class = !m.translates?
          #     [{name: :published}, {name: :name, if: is_translation_class}, {name: :content, if: is_translation_class}, {name: :description, if: is_translation_class}, {name: :url_fragment, if: is_translation_class}, :translations, :avatar, :released_at, :seo_tags, :sitemap_record].each do |f|
          #       f = {name: f} unless f.is_a?(Hash)
          #
          #       if m.new.respond_to?(f[:name])
          #         configure f[:name] do
          #           hide unless f[:if]
          #           label I18n.t("plugins.acts_as_article.#{f}") do
          #             "hello"
          #             #model.human_attribute_name(f)
          #             #I18n.t("plugins.acts_as_article.#{f}")
          #           end
          #         end
          #       end
          #     end
          #   end
          # end

          RailsAdmin.config(self) do
            field :published do
              label I18n.t("plugins.acts_as_article.published")
            end
            field :translations, :globalize_tabs do
              label I18n.t("plugins.acts_as_article.translations")
            end
            field :avatar do
              label I18n.t("plugins.acts_as_article.avatar")
            end
            field :released_at do
              label I18n.t("plugins.acts_as_article.released_at")
            end
            field :seo_tags do
              label I18n.t("plugins.acts_as_article.seo_tags")
            end
            field :sitemap_record do
              label I18n.t("plugins.acts_as_article.sitemap_record")
            end
          end

          RailsAdmin.config(self.translation_class) do
            visible false
            field :locale, :hidden
            field :name do
              label I18n.t("plugins.acts_as_article.name")
            end
            field :url_fragment do
              label I18n.t("plugins.acts_as_article.url_fragment")
            end
            field :description do
              label I18n.t("plugins.acts_as_article.description")
            end
            field :content, :ck_editor do
              label I18n.t("plugins.acts_as_article.content")
            end
          end
        end

        def configure_page_model
          page_model = false
          page_translation_model = false

          if ActiveRecord::Base.connection.tables.include?(self.table_name)
            RailsAdmin.config.included_models += [self]
            page_model = true

            if ActiveRecord::Base.connection.tables.include?(self.translation_class.table_name)
              RailsAdmin.config.included_models += [self.translation_class]
              page_translation_model = true
            end
          end

          model = self

          if page_model
            RailsAdmin.config(self) do
              navigation_label do
                I18n.t("admin.navigation_labels.pages", rescue: true) rescue "Pages"
              end
              configure :type do
                hide
              end
              configure :content if model.new.respond_to?(:content)
              configure :url do
                hide
              end
              configure :translations, :globalize_tabs
              #field :seo_tags
              #field :sitemap_record
            end
          end

          if page_translation_model
            RailsAdmin.config(self.translation_class) do
              visible false
              configure :locale, :hidden

              [:globalized_model, :type].each do |f|
                configure f do
                  hide
                end
              end


              #configure
              #field :url
            end
          end
        end




      end

      module InstanceMethods




      end
    end
  end
end


ActiveRecord::Base.send(:extend, Cms::Articles::ActiveRecordBaseExtension::ClassMethods)
