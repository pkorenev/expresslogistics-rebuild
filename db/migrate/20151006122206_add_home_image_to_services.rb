class AddHomeImageToServices < ActiveRecord::Migration
  def change
    add_column :services, :home_avatar_file_name,    :string
    add_column :services, :home_avatar_content_type, :string
    add_column :services, :home_avatar_file_size,    :integer
    add_column :services, :home_avatar_updated_at,   :datetime
  end
end
