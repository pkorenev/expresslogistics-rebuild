module Pages
  class OrderPage < ActiveRecord::Base
    acts_as_page

    [:background_image].each do |attachment_name|
      has_attached_file attachment_name
      attr_accessible attachment_name
      do_not_validate_attachment_file_type attachment_name
    end

    has_html_block :intro
  end
end