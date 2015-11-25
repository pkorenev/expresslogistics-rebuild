module Pages
  class ContactPage < ActiveRecord::Base
    acts_as_page

    has_html_block :contact_data
    #has_html_block :managers

    [:background_image].each do |attachment_name|
      has_attached_file attachment_name
      attr_accessible attachment_name
      do_not_validate_attachment_file_type attachment_name
    end
  end
end