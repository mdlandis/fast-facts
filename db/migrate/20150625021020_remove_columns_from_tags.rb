class RemoveColumnsFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :tag_category
  end
end
