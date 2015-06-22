class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.text :fact_text

      t.text :notes
      t.string :entered_by
      t.string :last_modified_by

      t.string :source_url
      t.string :source_title
      t.string :source_authors
      t.string :source_date_published
      t.string :original_source

      t.timestamps
    end
  end
end
