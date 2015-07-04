class MakeDatePublishedAHash < ActiveRecord::Migration
  def change
    remove_column :sources, :date_published
    add_column :sources, :date_published, :date
  end
end
