class Article < ActiveRecord::Base
  attr_accessible *attribute_names

  acts_as_article avatar: {styles: { small: '160x160#', medium: '380x380#' } }

  scope :home_featured, -> { published.last(4) }



end
