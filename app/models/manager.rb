class Manager < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :manager_group
  attr_accessible :manager_group, :manager_group_id

  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  enable_globalize_getters

  class Translation
    attr_accessible *attribute_names
  end
end
