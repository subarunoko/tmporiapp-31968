class ArticleTag

  include ActiveModel::Model
  attr_accessor :title, :body, :name, :article_id, :tag_ids, :user_id

  with_options presence: true do
    validates :title, length: { maximum: 30, message: "の文字数の上限を超えてます\n修正して下さい" }
    validates :body, length: { maximum: 2000, message: "の文字数の上限を超えてます\n修正して下さい" }
    # validates :name  
  end


  def save
    @article = Article.create(title: title, body: body, user_id: user_id)
    tag_list = tag_ids.split(/[[:blank]]+/).select(&:present?)
    tag_list.each do |tag_name|
      @tag = Tag.where(name: tag_name).first_or_initialize
      @tag.save
      unless ArticleTagRelation.create(article_id: @article.id, tag_id: @tag.id).exists?
        ArticleTagRelation.create(article_id: @article.id, tag_id: @tag.id)
      end
    end

      # # article = Article.create(title: title, body: body)
    # # tag = Tag.create(name: name)
    # tag = Tag.where(name: name).first_or_initialize
    # tag.save

    # ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end

end