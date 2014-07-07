class Mapping < ActiveRecord::Base
  belongs_to :parent, class_name: "Tag"
  belongs_to :child, class_name: "Tag"
  validates :parent_id, :child_id, presence: true
  validates :votes, presence: true, numericality: { greater_than: 0 }
end
