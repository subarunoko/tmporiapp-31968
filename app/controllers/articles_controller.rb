class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy, :destroy_caution]   
  before_action :authenticate_user!, except: [:index ,:show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy, :destroy_caution]
  
  def index
    @articles = Article.includes(:user).order("created_at DESC")
  end

  def new
    # @article = Article.new
    @article = ArticleTag.new
  end

  def create
    # @article = Article.new(article_params)
    # binding.pry
    @article = ArticleTag.new(article_params)
    # tag_list = params[:article_tag][:name].split(",")
    if @article.valid?
      @article.save
      redirect_to action: :create_done
    else
      render :new
    end

  end

  def create_done
    # @item = Article.order(updated_at: :desc).limit(1)       #最新のレコード1件取得
    # @item = @item[0]
  end

  def destroy
    if @article.destroy
      redirect_to action: :destroy_done # "削除成功" 完了ページへ戻る
    else
      render :destroy
    end
  end

  def destroy_caution
  end

  def destroy_done
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to action: :update_done   # "保存成功" 完了ページへ戻る
    else
      render :edit
    end
  end

  def update_done
  end

  def show
  end



  def attach
    attachment = Attachment.create! image: params[:image]
    render json: { filename: url_for(attachment.image) }
  end



  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    # binding.pry
    # params.require(:article).permit(:title, :body).merge(user_id: current_user.id)
    params.require(:article_tag).permit(:title, :body, :name, :tag_ids).merge(user_id: current_user.id)
  end

  def contributor_confirmation
    if current_user != @article.user
      redirect_to root_path and return
    end
  end

end
