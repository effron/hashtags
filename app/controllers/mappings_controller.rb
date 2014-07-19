class MappingsController < ApplicationController

  def index
    @mappings = Mapping.top_ten(nil)
    @mapping = Mapping.new
  end

  def create
    mapping = Mapping.hash_tag(mapping_params)

    if mapping.save
      redirect_to "/#{@mapping.parent_content}"
    else
      flash[:error] = "Illegal hashtag!!! Must be only letters without spaces"
      redirect_to :back
    end
  end

  def show
    mapping = Mapping.hash_tag({parent_content: params[:grandparent_content], content: params[:parent_content]})
    if mapping.save
      parent = mapping.tag
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
