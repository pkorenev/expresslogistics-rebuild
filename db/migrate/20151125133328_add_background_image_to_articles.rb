class AddBackgroundImageToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.has_attached_file :background_image
    end
  end
end
