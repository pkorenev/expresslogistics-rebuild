module Cms
  class HtmlBlock < ActiveRecord::Base
    self.table_name = :html_blocks


    attr_accessible *attribute_names

    #belongs_to :attachable, polymorphic: true

    translates :content
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes

    class Translation
      attr_accessible *attribute_names
    end

    enable_globalize_getters
  end
end