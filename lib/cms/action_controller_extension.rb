module Cms
  module ActionControllerExtension
    module ClassMethods
      def setup_locale *args, &block
        with_options if: proc { !(params[:controller] =~ /\Arails_admin/) } do
          self.before_action :set_locale  #, :set_locale_links, *args, &block
          self.before_action :set_locale_links
        end
      end

      def skip_setup_locale **args, &block
        #self.skip_before_action :set_locale, **args, &block #, :set_locale_links, *args, &block
        self.skip_before_action :set_locale, :set_locale_links, **args, &block
      end


    end

    module InstanceMethods
      def set_locale
        #self.render inline: "hello"
        if !params[:controller].match(/^rails_admin/) && !(params[:controller] == 'error')

          params_locale = params[:locale]
          locale = params_locale

          cookies_locale = cookies[:locale]

          if !locale || !I18n.available_locales.include?(locale.to_sym)
            locale = cookies_locale
          end

          if !locale || !I18n.available_locales.include?(locale.to_sym)
            locale = http_accept_language.compatible_language_from(I18n.available_locales)
          end

          if locale != cookies_locale
            cookies[:locale] = {
                value: locale,
                expires: 1.year.from_now
            }
          end

          #render inline: "locale: #{locale.inspect}"

          #logger.debug "locale: #{locale.inspect}"
          #logger.debug "params_locale: #{params_locale.inspect}"
          #logger.debug "cookies_locale: #{cookies_locale.inspect}"

          #return render inline: "#{locale != params_locale}"
          if locale != params_locale
            redirect_to locale: locale, :status => :moved_permanently
          else
            I18n.locale = locale
          end
        elsif params[:controller].match(/^rails_admin/)
          I18n.locale = :uk
        end

      end

      def set_locale_links
        #render inline: params[:route_name].to_s
        @locale_links = {}
        I18n.available_locales.each do |locale|
          if params[:localized]
            @locale_links[locale.to_sym] = send("#{params[:route_name]}_#{I18n.locale}_path" )
            next
          elsif params[:route_name]
            @locale_links[locale.to_sym] = send("#{params[:route_name]}_path", locale: locale )
          else
            @locale_links[locale.to_sym] = url_for(locale: locale)
          end
          # begin

          # rescue
          #   #@locale_links[locale.to_sym] =
          # end
        end
      end


    end
  end
end

ActionController::Base.send(:extend, Cms::ActionControllerExtension::ClassMethods)
ActionController::Base.send(:include, Cms::ActionControllerExtension::InstanceMethods)