module Pages
  class ContactPage < ActiveRecord::Base
    acts_as_page

    has_html_block :contact_data
    has_html_block :managers
  end
end