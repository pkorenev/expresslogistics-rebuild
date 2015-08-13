class ServicesController < ApplicationController
  before_action :set_service
  before_action :set_services_breadcrumbs
  before_action :set_service_locale_links, except: [:index]

  def show

    if @service.nil?
      render_not_found
    else
      @breadcrumbs << { url: send("service_path", id: @service.get_url_fragment), name: @service.get_name }
    end
  end

  def index
    @services = Service.published.default_order
  end

  def set_services_breadcrumbs
    @breadcrumbs ||= []
    @breadcrumbs << { url: root_path, name: I18n.t("breadcrumbs.root") }
    @breadcrumbs << { url: send("services_path"), name: I18n.t("breadcrumbs.services") }
  end

  def set_service
    @service = Service.find_by_translation_url_fragment(params[:id])
  end

  def set_service_locale_links
    I18n.available_locales.each do |locale|
      @locale_links[locale.to_sym] = send "service_#{locale}_path", id: @service.get_url_fragment(locale)
    end
  end
end
