unless !!ENV['si']
  require_relative 'require_libs'

  def pages_navigation_label
    navigation_label do
      I18n.t("admin.navigation_labels.pages")
    end
  end


  def settings_navigation_label
    navigation_label do
      I18n.t("admin.navigation_labels.settings")
    end
  end

  def include_models(config, *models)
    models.each do |model|
      config.included_models += [model]

      if !model.instance_of?(Class)
        Dir[Rails.root.join("app/models/#{model.underscore}")].each do |file_name|
          require file_name
        end

        model = model.constantize rescue nil
      end

      if model.respond_to?(:translates?) && model.translates?
        config.included_models += [model.translation_class]
      end
    end
  end

  RailsAdmin.config do |config|

    ### Popular gems integration

    ## == Devise ==
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)

    ## == Cancan ==
    # config.authorize_with :cancan

    ## == PaperTrail ==
    # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

    ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

    config.actions do
      dashboard                     # mandatory
      index                         # mandatory
      new
      export
      bulk_delete
      show
      edit
      delete
      show_in_app

      ## With an audit adapter, you can add:
      # history_index
      # history_show
    end

    Article.configure_article_model
    Service.configure_article_model


    Cms.configure_page_models
    include_models Pages::AboutPage, Pages::ArticlesPage, Pages::ContactPage, Pages::HomePage, Pages::HomePage, Pages::OrderPage, Pages::ServicesPage

    include_models config, Manager, ManagerGroup, FormConfigs::ContactFeedback, FormConfigs::Order






    config.model Service do
      field :published do
        label I18n.t("plugins.acts_as_article.published")
      end
      field :translations, :globalize_tabs do
        label I18n.t("plugins.acts_as_article.translations")
      end
      field :avatar do
        label I18n.t("plugins.acts_as_article.avatar")
      end
      field :home_avatar do
        label "аватарка для головної сторінки"
      end
      field :background_image do
        label "фонова картинка (в самій одиниці)"
      end
      field :released_at do
        label I18n.t("plugins.acts_as_article.released_at")
      end
      field :seo_tags do
        label I18n.t("plugins.acts_as_article.seo_tags")
      end
      field :sitemap_record do
        label I18n.t("plugins.acts_as_article.sitemap_record")
      end
    end


    config.model Cms::HtmlBlock do
      visible false

      nested do
        field :translations, :globalize_tabs
      end
    end

    config.model Cms::HtmlBlock.translation_class do
      visible false

      nested do
        field :locale, :hidden
        field :content
      end
    end

    config.model Cms::Page do
      visible false
    end




    config.model Cms::MetaTags do
      visible false

      nested do
        field :translations, :globalize_tabs
      end
    end

    config.model Cms::MetaTags::Translation do
      visible false

      nested do
        field :locale, :hidden
        field :title
        field :description
        field :keywords
      end
    end



    config.model Pages::HomePage do
      pages_navigation_label

      edit do
        field :background_image
        field :welcome_html
        field :block_under_welcome_html
        field :seo_tags
      end
    end

    config.model Pages::ContactPage do
      pages_navigation_label

      field :background_image
      field :contact_data
      field :seo_tags
    end

    config.model Pages::OrderPage do
      pages_navigation_label

      field :background_image
      field :seo_tags
      field :content
    end

    config.model Pages::ServicesPage do
      pages_navigation_label

      field :background_image
      field :seo_tags
      field :content
    end

    config.model Pages::AboutPage do
      pages_navigation_label

      field :background_image
      field :seo_tags
      field :content
    end

    config.model Pages::ArticlesPage do
      pages_navigation_label

      field :background_image
      field :seo_tags
    end

    config.model Manager do
      visible true

      # edit do
      #   field :manager_group
      #   field :email
      #   field :phone
      #   field :translations, :globalize_tabs
      # end

      edit do
        field :manager_group
        field :email
        field :phone
        field :translations, :globalize_tabs
      end
    end

    config.model Manager.translation_class do
      visible false
      nested do
        field :locale, :hidden
        field :name
      end
    end

    config.model ManagerGroup do
      edit do
        field :translations, :globalize_tabs
      end
    end

    config.model ManagerGroup.translation_class do
      visible false
      nested do
        field :locale, :hidden
        field :name
      end
    end


    %w(ContactFeedback Order).each do |name|
      config.model "FormConfigs::#{name}" do
        settings_navigation_label
        visible true
        list do
          field :email_receivers
        end

        edit do
          field :email_receivers do
            label "Емейли отримувачів"
            help "кожен емейл в новому рядку"
          end
        end
      end
    end

  end
end