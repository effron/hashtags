class Tag < ActiveRecord::Base

  has_many :child_mappings, class_name: "Mapping", foreign_key: :parent_id
  has_many :mappings
  has_many :votes, through: :mappings

  attr_accessor :parent_content

  before_validation :hashify

  validates :content, presence: true, uniqueness: true, format: { with: %r{\A[a-z]+\z}, message: "must be alphabetical" }

  private

  def hashify
    self.content = content.downcase
  end

end
