class RemoveVotesColumnsFromMappingsAndTags < ActiveRecord::Migration
  def change
    remove_column :tags, :votes
    remove_column :mappings, :votes
  end
end
