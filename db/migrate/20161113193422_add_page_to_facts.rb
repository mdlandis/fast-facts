class AddPageToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :page, :string
  end
end
