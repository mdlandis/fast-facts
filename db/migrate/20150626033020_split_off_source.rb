class SplitOffSource < ActiveRecord::Migration
  def change
    remove_column :facts, :source_url
    remove_column :facts, :source_title
    remove_column :facts, :source_authors
    remove_column :facts, :source_date_published
    remove_column :facts, :original_source

    create_table :sources do |t|

      t.string :url
      t.string :title
      t.string :authors
      t.string :date_published
      t.string :original_source


    end

  end
end
