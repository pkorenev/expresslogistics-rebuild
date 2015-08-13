class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :locale
      t.string :customer_firm
      t.string :contact_name
      t.string :transport_type
      t.string :transport_from
      t.string :transport_to
      t.string :transport_distance
      t.string :volume
      t.string :estimated_date
      t.string :contact_phone
      t.string :email
      t.text :comment
      t.timestamps null: false
    end
  end
end
