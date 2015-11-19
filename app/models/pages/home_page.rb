module Pages
  class HomePage < ActiveRecord::Base
    acts_as_page(false)

    has_html_block :welcome_html
    has_html_block :block_under_welcome_html
  end
end