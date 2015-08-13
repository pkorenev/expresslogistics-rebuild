class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  acts_as_article avatar: {styles: { small: '160x160#', medium: '380x380#', extra_small: "90x90#" } }

  scope :home_featured, -> { published.last(6) }
end
