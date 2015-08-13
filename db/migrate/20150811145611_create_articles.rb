class CreateArticles < ActiveRecord::Migration
  def up
    Article.create_articles_table
  end

  def down
    Article.drop_articles_table
  end
end
