class CreateServices < ActiveRecord::Migration
  def up
    Service.create_articles_table
  end

  def down
    Service.drop_articles_table
  end
end
