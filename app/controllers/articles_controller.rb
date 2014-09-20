class ArticlesController < ApplicationController
  before_action :require_admin, only: [ :new, :edit, :create, :update, :destroy ]
  before_action {
    breadcrumbs.add(url: '/blog', title: 'Blog')
  }
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.published.limit(10)
  end

  # GET /articles/1
  # GET /articles/1.json
  # Only show articles with section name 'blog'
  def show
    redirect_to '/' unless @article && @article.section_blog?
  end

  # GET /articles/new
  def new
    @article = Article.new(author: current_user!)
    self.page_title = "New Article"
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.author = current_user!

    respond_with(@article)
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article.update(article_params) and flash[:notice]='Article was successfully updated.'
    respond_with(@article)
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:status, :section, :graveyard_id, :headline, :path, :published_at, :teaser, :body).tap do |a|
        # a.author_id = current_user!.id
      end
    end
end
