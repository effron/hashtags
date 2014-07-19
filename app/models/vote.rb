class Vote < ActiveRecord::Base
  belongs_to :mapping

  validates :mapping_id, presence: true
end
