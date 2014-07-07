class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.integer :parent_id, nil: false
      t.integer :child_id, nil: false
      t.integer :votes, nil: false

      t.timestamps
    end
  end
end
