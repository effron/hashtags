class ChangeChildIdToTagId < ActiveRecord::Migration
  def change
    rename_column :mappings, :child_id, :tag_id
  end
end
