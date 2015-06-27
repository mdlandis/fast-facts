class AddFactsTagsTable < ActiveRecord::Migration
  def change
    create_table :facts_tags, id: false do |t|
      t.belongs_to :fact, index: true
      t.belongs_to :tag, index: true
    end
  end
end

