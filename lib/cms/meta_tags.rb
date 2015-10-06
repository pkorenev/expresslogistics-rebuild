module Cms
  class MetaTags < ActiveRecord::Base
    self.table_name = :seo_tags

    attr_accessible *attribute_names

    belongs_to :page, polymorphic: true
    attr_accessible :page

    translates :title, :keywords, :description
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes

    class Translation
      self.table_name = :seo_tags_translations
      attr_accessible *attribute_names
      belongs_to :meta_tags

      rails_admin do
        edit do
          field :locale, :hidden
          field :title
          field :keywords
          field :description
        end
      end
    end

    rails_admin do
      edit do
        field :translations, :globalize_tabs
      end
    end
  end
end


