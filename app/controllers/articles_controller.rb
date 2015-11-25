class ArticlesController < ApplicationController
  before_action :set_article
  before_action :set_articles_breadcrumbs
  before_action :set_article_locale_links, except: :index

  def show
    @article = Article.find_by_translation_url_fragment(params[:id])
    if @article.nil?
      render_not_found
    else
      @breadcrumbs << { url: send("article_path", id: @article.get_url_fragment), name: @article.get_name }
      @page = @article

    end
  end

  def index
    @articles = Article.published.default_order
    @page = Pages::ArticlesPage.first
  end

  def set_article
    @article = Article.find_by_translation_url_fragment(params[:id])
  end

  def set_articles_breadcrumbs
    @breadcrumbs ||= []
    @breadcrumbs << { url: root_path, name: I18n.t("breadcrumbs.root") }
    @breadcrumbs << { url: send("articles_path"), name: I18n.t("breadcrumbs.articles") }
  end

  def set_article_locale_links
    I18n.available_locales.each do |locale|
      @locale_links[locale.to_sym] = send "article_#{locale}_path", id: @article.get_url_fragment(locale)
    end
  end
end
