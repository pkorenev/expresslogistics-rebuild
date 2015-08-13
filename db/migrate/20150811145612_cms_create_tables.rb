class CmsCreateTables < ActiveRecord::Migration
  def up
    create_cms_tables
    create_pages_table do |t|

    end
  end

  def down
    drop_cms_tables
  end
end
