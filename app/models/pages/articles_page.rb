class Pages::ArticlesPage < Cms::Page
  [:background_image].each do |attachment_name|
    has_attached_file attachment_name
    attr_accessible attachment_name
    do_not_validate_attachment_file_type attachment_name
  end
end