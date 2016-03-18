class CreateHomeBanners < ActiveRecord::Migration
  def up
    create_table :home_banners do |t|
      t.boolean :published
      t.integer :sorting_position
      t.attachment :image
      t.text :description
    end
    HomeBanner.initialize_globalize
    HomeBanner.create_translation_table!(description: :text)
  end

  def down
  	HomeBanner.drop_translation_table!

  	drop_table :home_banners
  end	
end
