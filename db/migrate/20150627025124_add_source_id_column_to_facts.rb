class AddSourceIdColumnToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :source_id, :integer
  end
end
