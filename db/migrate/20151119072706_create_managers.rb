class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.belongs_to :manager_group
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps null: false
    end

    Manager.create_translation_table!(name: :string)
  end
end
