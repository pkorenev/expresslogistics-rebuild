class AddBackgroundImageToPages < ActiveRecord::Migration
  def change
    [Page].each do |model|
      change_table model.table_name do |t|
        t.has_attached_file :background_image
      end
    end
  end
end
