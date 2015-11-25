class AddBackgroundImageToServices < ActiveRecord::Migration
  def change
    change_table :services do |t|
       t.has_attached_file :background_image
    end
  end
end
