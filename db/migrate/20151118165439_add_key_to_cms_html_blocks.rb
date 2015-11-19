class AddKeyToCmsHtmlBlocks < ActiveRecord::Migration
  def change
    add_column :html_blocks, :key, :string
  end
end
