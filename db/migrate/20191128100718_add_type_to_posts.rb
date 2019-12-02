class AddTypeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :noodle, :string
    add_column :posts, :soup, :string
  end
end
