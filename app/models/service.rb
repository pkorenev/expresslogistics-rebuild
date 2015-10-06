class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  acts_as_article avatar: {styles: { small: '160x160#', medium: '380x380#', extra_small: "90x90#" } }

  scope :home_featured, -> { published.last(6) }

  has_attached_file :home_avatar
  attr_accessible :home_avatar

  do_not_validate_attachment_file_type :home_avatar
end
