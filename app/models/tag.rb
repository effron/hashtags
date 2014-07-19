class Tag < ActiveRecord::Base

  has_many :parent_mappings, class_name: "Mapping", foreign_key: :parent_id
  has_many :mappings
  has_many :votes, through: :parent_mappings

  attr_accessor :parent_content

  before_validation :hashify

  validates :content, presence: true, uniqueness: true, format: { with: %r{\A[a-z]+\z}, message: "must be alphabetical" }

  def self.hashtag(content)
    Tag.where(content: content.downcase).first_or_initialize.tap do |tag|
      mapping = Mapping.where(tag: tag, parent: nil).first_or_create
      Vote.create(mapping: mapping)
    end
  end

  def top_ten
    child_mappings.includes(:child).order(votes: :desc).limit(10).map(&:child)
  end

  private

  def hashify
    self.content = content.downcase
  end

end
