class SingleArticlesController < AppBaseController
  layout "application_new"
  
  def show
    @data = SingleArticle.find(params[:id])
  end
end