class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  setup_locale
  skip_around_filter :set_locale_from_url


  def render_not_found
    render template: "errors/not_found"
  end
end
