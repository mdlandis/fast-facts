class RenameTagsTagCategoryColumn < ActiveRecord::Migration
  def change
    rename_column :tags, :category, :category_id
  end
end
