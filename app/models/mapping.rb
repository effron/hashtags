class Mapping < ActiveRecord::Base
  belongs_to :parent, class_name: "Tag"
  belongs_to :tag
  has_many :votes
  validates :tag_id, presence: true

  after_save :tally_vote_and_upvote_parent

  def self.top_ten(parent)
    having_clause = parent.blank? ? "IS NULL" : "= ?"
 
    select("mappings.*, count(votes.id) AS mappings_count").
    joins(:votes).
    group("mappings.id").
    order("mappings_count DESC").
    having("mappings.parent_id #{having_clause}", parent && parent.id).
    limit(10)
  end

  def self.hash_tag(params)
    parent_string = params[:parent_content] || ''

    parent = Tag.where(content: parent_string.downcase).first_or_create
    tag = Tag.where(content: params[:content].downcase).first_or_create

    mapping = Mapping.where(parent: parent, tag: tag).first_or_initialize

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

  private

  def tally_vote_and_upvote_parent
    votes.create!
    unless parent.nil?
      toplevel = Mapping.where(tag: parent, parent: nil).first
      toplevel.votes.create!
    end
  end
end
