class Tag < ActiveRecord::Base

  has_many :parent_mappings, class_name: "Mapping", foreign_key: :child_id
  has_many :child_mappings, class_name: "Mapping", foreign_key: :parent_id

  attr_accessor :parent_content

  after_initialize :set_votes
  before_validation :hashify
  after_save :persist_parent

  validates :content, presence: true, uniqueness: true, format: { with: %r{\A[a-z]+\z}, message: "must be alphabetical" }

  def self.top_ten
    Tag.all.order(votes: :desc).limit(10)
  end

  def self.hashtag(content)
    Tag.where(content: content).first_or_initialize.tap do |tag|
      tag.votes += 1
    end
  end

  def top_ten
    child_mappings.includes(:child).order(votes: :desc).limit(10).map(&:child)
  end

  private

  def set_votes
    self.votes ||= 0
  end

  def persist_parent
    unless parent_content.blank?
      parent = Tag.where(content: parent_content).first_or_create!
      mapping = parent_mappings.where(parent_id: parent.id).first_or_create do |mapping|
        mapping.votes ||= 0
        mapping.votes += 1
      end
    end
  end

  def hashify
    self.content = content.downcase
  end


end
