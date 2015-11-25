class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  setup_locale
  skip_around_filter :set_locale_from_url

  before_action :set_locale_for_admin

  def set_locale_for_admin
    if params[:controller] =~ /rails_admin/
      I18n.locale = :uk
    end
  end


  def render_not_found
    render template: "errors/not_found"
  end
end
