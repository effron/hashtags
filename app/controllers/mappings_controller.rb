class MappingsController < ApplicationController

  def index
    @mappings = Mapping.top_ten(nil)
    @mapping = Mapping.new
  end

  def create
    @mapping = Mapping.hash_tag(mapping_params)
    @mappings = Mapping.top_ten(params[:parent_content])
    if @mapping.save
      redirect_to "/#{@mapping.parent_content}"
    else
      render 'index'
    end
  end

  def show
    parent = Tag.hashtag(params[:parent_content])
    if parent.save
      @mappings = Mapping.top_ten(parent)
      @mapping = Mapping.new
      @mapping.parent = parent
      render 'index'
    else
      render status: :not_found
    end
  end

  private

  def mapping_params
    params.require(:mapping).permit(:content, :parent_content)
  end
end
