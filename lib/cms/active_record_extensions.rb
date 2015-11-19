module Cms
  module ActiveRecordExtensions
    module ClassMethods
      def has_seo_tags
        has_one :seo_tags, class_name: "Cms::MetaTags", as: :page, autosave: true
        accepts_nested_attributes_for :seo_tags
        attr_accessible :seo_tags, :seo_tags_attributes
      end

      def has_sitemap_record
        has_one :sitemap_record, class_name: "Cms::SitemapElement", as: :page
        accepts_nested_attributes_for :sitemap_record
        attr_accessible :sitemap_record, :sitemap_record_attributes
      end

      # def has_html_block(name)
      #   name = name.to_sym
      #   has_one name, -> { where(attachable_field_name: name) }, class_name: "Cms::HtmlBlock", as: :attachable, autosave: true
      #   accepts_nested_attributes_for name
      #   attr_accessible name, "#{name}_attributes".to_sym
      #   self.send :define_method, "get_#{name}" do |locale = I18n.locale|
      #     owner = self.association(name).owner
      #     owner_class = owner.class
      #     HtmlBlock.all.where(attachable_type: owner_class.name, attachable_id: owner.id, attachable_field_name: name).first.try(&:get_content)
      #   end
      #
      #
      # end

      def has_html_block(*names)
        names = [:content] if names.empty?
        if self._reflections[:html_blocks].nil?
          has_many :html_blocks, class_name: "Cms::HtmlBlock", as: :attachable
        end
        names.each do |name|
          name = name.to_sym

          if !has_html_block_field_name?(name)
            if self.class_variable_defined?(:@@html_field_names)
              html_field_names = self.class_variable_get(:@@html_field_names)
            end
            html_field_names ||= []

            html_field_names << name.to_s
            class_variable_set(:@@html_field_names, html_field_names)


            has_one name, -> { where(attachable_field_name: name) }, class_name: "Cms::HtmlBlock", as: :attachable, autosave: true
            accepts_nested_attributes_for name
            attr_accessible name, "#{name}_attributes".to_sym
            # define_method "#{name}" do |locale = I18n.locale|
            #   owner = self.association(name).owner
            #   owner_class = owner.class
            #   HtmlBlock.all.where(attachable_type: owner_class.name, attachable_id: owner.id, attachable_field_name: name).first.try(&:content)
            # end
          end
        end
      end

      def html_block_field_names
        return [] if !class_variable_defined?(:@@html_field_names)
        class_variable_get(:@@html_field_names) || []
      end

      def has_html_block_field_name?(name)
        self.class_variable_defined?(:@@html_field_names) && (names = self.class_variable_get(:@@html_field_names)).present? && names.include?(name.to_s)
      end

      def acts_as_page(has_content = true)
        self.table_name = :pages

        has_seo_tags
        has_sitemap_record

        has_html_block :content if has_content

        translates :url
        accepts_nested_attributes_for :translations
        attr_accessible :translations, :translations_attributes

        self.class_eval "class Translation; self.table_name = :page_translations;attr_accessible *attribute_names; end;"
      end

      def safe_drop_translation_table(*args, &block)
        self.drop_translation_table!(*args, &block) if ActiveRecord::Base.connection.tables.include?(translation_class.table_name)
      end

      def safe_create_translation_table(*args, &block)
        self.create_translation_table!(*args, &block) unless ActiveRecord::Base.connection.tables.include?(translation_class.table_name.to_s)
      end
    end

    module Migrations
      module ClassMethods
        def create_seo_tags_table
          safe_create_table :seo_tags do |t|
            t.string :title
            t.text :description
            t.text :keywords

            t.string :page_type
            t.integer :page_id

            t.timestamps null: false
          end

          MetaTags.safe_create_translation_table
        end

        def drop_seo_tags_table
          safe_drop_table :seo_tags

          MetaTags.safe_drop_translation_table
        end

        def create_sitemap_elements_table
          safe_create_table :sitemap_elements do |t|
            t.string :page_type
            t.integer :page_id

            t.boolean :display_on_sitemap
            t.string :changefreq
            t.float :priority

            t.timestamps null: false
          end
        end

        def drop_sitemap_elements_table
          safe_drop_table :sitemap_elements
        end

        def create_html_blocks_table
          safe_create_table :html_blocks do |t|
            t.text :content

            t.integer :attachable_id
            t.string :attachable_type
            t.string :attachable_field_name
          end

          Cms::HtmlBlock.safe_create_translation_table(content: :text)
        end

        def drop_html_blocks_table
          Cms::HtmlBlock.safe_drop_translation_table

          safe_drop_table :html_blocks
        end

        def create_pages_table
          safe_create_table :pages do |t|
            t.string :url
            t.string :type
            yield t
          end

          Cms::Page.safe_create_translation_table(url: :string)

          change_table Cms::Page.translation_class.table_name do |t|
            t.string :type
          end

        end

        def drop_pages_table
          safe_drop_table :pages

          Cms::Page.safe_drop_translation_table
        end

        def create_cms_tables
          create_seo_tags_table
          create_sitemap_elements_table
          create_html_blocks_table
        end

        def drop_cms_tables
          drop_seo_tags_table
          drop_sitemap_elements_table
          drop_html_blocks_table
          drop_pages_table
        end

        def safe_drop_table name, *args
          drop_table name, *args if ActiveRecord::Base.connection.tables.include?(name.to_s)
        end

        def safe_create_table name, *args, &block
          create_table(name, *args, &block) unless ActiveRecord::Base.connection.tables.include?(name.to_s)

        end




      end
    end
  end
end

ActiveRecord::Base.send(:extend, Cms::ActiveRecordExtensions::ClassMethods)

ActiveRecord::Migration.send(:include, Cms::ActiveRecordExtensions::Migrations::ClassMethods)