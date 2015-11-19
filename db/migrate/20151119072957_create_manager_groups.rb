class CreateManagerGroups < ActiveRecord::Migration
  def change
    create_table :manager_groups do |t|
      t.string :name

      t.timestamps null: false
    end

    ManagerGroup.create_translation_table!(name: :string)
  end
end
