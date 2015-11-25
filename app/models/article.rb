class Article < ActiveRecord::Base
  attr_accessible *attribute_names

  acts_as_article avatar: {styles: { small: '160x160#', medium: '380x380#' } }

  scope :home_featured, -> { published.last(4) }

  [:background_image].each do |attachment_name|
    has_attached_file attachment_name
    attr_accessible attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

end
