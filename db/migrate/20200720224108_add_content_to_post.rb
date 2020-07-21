class AddContentToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :two_content, :text
    add_column :posts, :three_content, :text
    add_column :posts, :four_content, :text
    add_column :posts, :five_content, :text
    add_column :posts, :hashtag, :text
  end
end
