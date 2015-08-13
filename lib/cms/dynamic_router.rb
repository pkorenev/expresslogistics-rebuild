module Cms
  class DynamicRouter
    def self.add_route(path, options = {})
      locale = options.delete :locale

      route_name = options.delete :route_name
      locale_route_name = "#{route_name}_#{locale}".to_sym
      options[:as] = locale_route_name

      options[:defaults] ||= {}
      options[:defaults][:route_name] ||= route_name
      options[:defaults][:predefined_locale] ||= locale
      options[:constraints] ||= { locale: /[a-zA-Z]{2,2}/ }

      options[:via] ||= :get


      started_with_slash = path.try{|t_path| t_path.scan(/\A\//).any? }
      path = "/#{path}" unless started_with_slash
      path = "(:locale)#{path}"



      @@route_names ||= []

      if !@@route_names.include?(locale_route_name)
        @@route_names << locale_route_name
        @@mapper.match path, options
      end
    end

    def self.load


      Rails.application.class.routes.draw do
        @@mapper = self

        #DynamicRouter.load_pages if ActiveRecord::Base.connection.tables.include?('pages')
        DynamicRouter.load_static_routes
      end
    end

    def self.resources_routes(*resources)
      resources.each do |resource|
        resource_class = resource.singularize.classify.constantize
        controller_class = "#{resource.classify}Controller".constantize

      end
    end

    def self.load_static_routes(options = {})
      page_classes = Cms.page_models(options)

      page_classes.each do |page_class|
        route_name = page_class.name.underscore.gsub(/\Apages\//, '')
        action_name = route_name.gsub(/_page\Z/, "")
        path = I18n.t("routes.#{route_name}", locale: :en, throw: true) rescue action_name.parameterize
        if action_name == 'home'
          route_name = "root"
          path = ""
          #next
        end

        use_route_translator_gem = false

        if use_route_translator_gem
          @@mapper.localized do

            path = route_name

            #@@mapper.get path, locale: :en, as: route_name, controller: "pages", action: action_name
            @@mapper.get path, as: route_name, controller: "pages", action: action_name
          end
        else
          I18n.available_locales.each do |locale|
            page_i18n_key = route_name.gsub(/\_page\Z/, '')
            localized_path = "(:locale)" if route_name == 'root'
            localized_path ||= "(:locale)/#{I18n.t("routes.pages.#{page_i18n_key}", locale: locale)}".gsub("//", '/')



            Rails.application.routes.url_helpers.module_eval do
              define_method "#{route_name}_path" do |*params, **options|
                options[:locale] ||= I18n.locale.to_sym
                send("#{route_name}_#{options[:locale]}_path", options)
              end
            end

            # @@mapper.instance_eval do
            #   self.send :define_method, "#{route_name}_path" do |*params, **options|
            #     options[:locale] ||= locale.to_sym
            #     send("#{route_name}_path", options)
            #   end
            # end

            @@mapper.get localized_path, as: "#{route_name}_#{locale}", constraints: { locale: locale.to_s }, controller: "pages", action: action_name, defaults: { route_name: route_name.to_sym, route_locale: locale.to_sym }

          end
        end
      end
    end

    def self.load_pages(options = {})

      pages = Cms::Page.all
      db_page_classes = pages.map(&:class).uniq

      page_classes = Cms.page_models(options)

      #puts page_classes.map(&:name).inspect

      #puts "page_classes: #{page_classes.map(&:name).inspect}\n"
      page_classes.map do |c|
        page_config = {}
        page_config[:paths] ||= {}



        if db_page_classes.include?(c)
          page = pages.select{|p| p.class == c }.first
          #page.translations.each do |t|
          #  page_config[:paths][t.locale.to_sym] = t.path if t.blank?
          #end

          add_page_route(page)
        else
          add_page_route(c)
        end


      end

      pages.each do |p|
        add_page_route(p)
      end



    end

    def self.add_page_route(page_or_class)
      #puts "page_or_class: #{page_or_class.inspect}\n+++++++++++++++++++++++++++++++++\n"
      input_by_class = page_or_class.instance_of?(Class)
      if page_or_class.instance_of?(Class)
        page_class = page_or_class
        page = page_class.new
      else
        page = page_or_class
        page_class ||= page.class
      end

      p = page
      load_from_database = false

      if load_from_database

      I18n.available_locales.each do |locale|

        # ====================================
        # set page path
        # ====================================

        page_class_name = p.class.name.split("::").last
        page_class_name = page_class_name[0, page_class_name.length - 4 ]

        page_path = page_class_name.parameterize
        page_path_from_class_method = false

        if page_class.respond_to?(:path)
          page_path_from_class_method = page_class.send(:path, locale)
          page_path = page_path_from_class_method if page_path_from_class_method.present?
        end

        #puts "page_class: #{page_class}"

        #puts "page_path: #{page_path}"

        unless input_by_class
          p_path = p.page_path_without_locale(locale)
          page_path = p_path if p_path.present?
        end

        #puts "page_path: #{page_path}"
        #puts "----------------------------------------"






        # ====================================
        # end set page path
        # ====================================


        page_action_name = page_class_name.underscore

        to = "pages##{page_action_name}"

        # ====================================
        # set page_route
        # ====================================

        route_name = "show_page_#{p.id}".to_sym
        resolve_route_name_by_page_class = true
        include_page_as_route_suffix = true

        if resolve_route_name_by_page_class
          route_name = p.class.name.split("::").last
          if include_page_as_route_suffix
            route_name = route_name.underscore
          else
            route_name = route_name[0, route_name.length - "Page".length].underscore
          end
        end

        # ====================================
        # end set page_route
        # ====================================


        if page_path.present?
          add_route page_path, route_name: route_name, to: to, defaults: { page_id: p.id }, locale: locale.to_sym
        end
      end

      else
        # route_name = class_name.eval
        # match I18n.t("")
      end
    end



    def self.reload
      Rails.application.class.routes_reloader.reload!
    end
  end
end