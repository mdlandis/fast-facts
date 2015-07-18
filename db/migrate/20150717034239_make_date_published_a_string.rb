class MakeDatePublishedAString < ActiveRecord::Migration
  def change
    remove_column :sources, :date_published
    add_column :sources, :date_published, :string
  end
end
