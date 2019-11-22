class RenameTopicIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :topic_id, :post_id
  end
end
