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
    end
  end
end