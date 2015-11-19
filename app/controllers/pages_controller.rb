class PagesController < ApplicationController
  before_action :set_home_breadcrumbs, except: [:home, :contact_feedback]
  before_action :set_page_class, :set_page_record, except: [:contact_feedback]

  def home
    @articles = Article.home_featured
    @services = Service.home_featured


  end

  def about

    #@content = Pages::AboutPage.first.try{|p| p.content }

  end

  def contact
  end

  def order
    @order = Order.new(params[:order])
    if @_request.post?
      if @order.valid?
        @order.save
        flash[:notice] = "Thanks for sending form"
        @order = Order.new
      end
    end
  end

  def contact_feedback
    @contact_feedback = ContactFeedback.create(contact_feedback_params)

    if @contact_feedback.save
      ExpressMailer.contact_feedback(@contact_feedback).deliver
      render inline: @contact_feedback.to_json, status: 201
    end
  end

  def set_home_breadcrumbs
    @breadcrumbs ||= []
    @breadcrumbs << { url: root_path, name: I18n.t("breadcrumbs.root") }
    @breadcrumbs << { url: send("#{params[:action]}_page_path"), name: I18n.t("breadcrumbs.pages.#{params[:action]}") }
  end

  def set_page_class
    @page_class_name = "Pages::#{params[:action].classify}Page"
    @page_class = Object.const_defined?(@page_class_name) ? @page_class_name.constantize : nil

   # render inline: "@page_class_name: #{@page_class_name}"
  end

  def set_page_record
    @page = @page_class.try &:first


  end

  def set_page_metadata

  end

  def contact_feedback_params
    p = params[:contact_feedback]
    p[:locale] = I18n.locale

    p
  end
end


