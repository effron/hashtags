class Tag < ActiveRecord::Base

  has_many :child_mappings, class_name: "Mapping", foreign_key: :parent_id
  has_many :mappings
  has_many :votes, through: :mappings

  before_validation :hashify

  validates :content, presence: true, uniqueness: true, format: { with: %r{\A[a-z]+\z}, message: "must be alphabetical" }

  after_create :save_mapping

  private

  def hashify
    self.content = content.downcase
  end

  def save_mapping
    mappings.create!
  end

end
