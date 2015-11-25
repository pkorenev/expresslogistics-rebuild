module Pages
  class HomePage < ActiveRecord::Base
    acts_as_page(false)

    has_html_block :welcome_html
    has_html_block :block_under_welcome_html

    [:background_image].each do |attachment_name|
      has_attached_file attachment_name
      attr_accessible attachment_name
      do_not_validate_attachment_file_type attachment_name
    end
  end
end