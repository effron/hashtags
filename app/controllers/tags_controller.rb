class TagsController < ApplicationController

  def index
    @tags = Tag.top_ten
    @tag = Tag.new
  end

  def create
    parent = Tag
    parent = parent.where(content: tag_params[:parent_content]) unless tag_params[:parent_content].blank?
    @tags = parent.top_ten
    @tag = Tag.where(content: tag_params[:content]).first_or_initialize
    @tag.parent_content = tag_params[:parent_content]
    @tag.votes += 1
    if @tag.save
      redirect_to "/#{@tag.parent_content}"
    else
      render 'index'
    end
  end

  def show
    parent = Tag.hashtag(params[:parent_content])
    if parent.save
      @tags = parent.top_ten
      @tag = Tag.new
      @tag.parent_content = parent.content
      render 'index'
    else
      render status: :not_found
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:content, :parent_content)
  end
end
