require_relative 'require_libs'

def pages_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.pages")
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


  config.model Cms::HtmlBlock do
    visible false
  end

  config.model Cms::Page do
    visible false
  end

  config.model Cms::HtmlBlock.translation_class do
    visible false

  end
end
