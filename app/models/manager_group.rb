class ManagerGroup < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :managers
  attr_accessible :managers, :manager_ids
  accepts_nested_attributes_for :managers
  attr_accessible :managers_attributes

  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations, :translations_attributes

  enable_globalize_getters

  class Translation
    attr_accessible *attribute_names
  end
end
