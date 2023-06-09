class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # 1 - Limit the actions...anyone can see the index and show article,
  # but if you are not logged in, you can't delete,create or edit
  before_action :require_user, except: [:index, :show]

  # 2 - To perform edit or delete we need to make sure that the current user is the one that create this article
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully ;)"
      redirect_to @article
    else
      render 'new'
    end
    # display error messages due to the validations
    # Validations and display messages
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was created successfully :)"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You only can edit or delete your own article"
      redirect_to @article
    end
  end
end
