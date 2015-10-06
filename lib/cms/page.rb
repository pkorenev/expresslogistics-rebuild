module Cms
  class Page < ActiveRecord::Base
    self.table_name = :pages
    attr_accessible *attribute_names
    translates :url
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes

    has_seo_tags

    class Translation
      self.table_name = :page_translations
      attr_accessible *attribute_names
      belongs_to :page, class_name: "Cms::Page"
    end
  end
end