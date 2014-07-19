class Mapping < ActiveRecord::Base
  belongs_to :parent, class_name: "Tag"
  belongs_to :tag
  has_many :votes
  validates :tag_id, presence: true

  def self.top_ten(parent)
    select("mappings.*, count(votes.id) AS mappings_count").
    joins(:votes).
    group("mappings.id").
    order("mappings_count DESC").
    having("mappings.parent_id = #{ parent.id }")
    limit(10)
  end

  def self.hash_tag(params)
    parent = Tag.where(content: params[:parent_content].downcase).first_or_create
    tag = Tag.where(content: params[:content].downcase).first_or_create

    mapping = Mapping.where(parent: parent, tag: tag).first_or_initialize

    vote = Vote.create(mapping: mapping)

    mapping
  end

  def content
    tag && tag.content
  end

  def score
    votes.size
  end

  def parent_content
    parent && parent.content
  end
end
