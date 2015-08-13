module Cms
  module GlobalizeExtensions
    module ClassMethods
      def enable_globalize_getters
        if self.respond_to?(:translates?) && self.translates?

          self.send(:include, Cms::GlobalizeExtensions::InstanceMethods)

          self.translated_attribute_names.each do |f|
            self.send :define_method, "get_#{f}" do |locale = I18n.locale|
              get_attr f, locale
            end
          end
        end
      end

      def find_by_translation_url_fragment url_fragment
        translations = self.translation_class.where(url_fragment: url_fragment)
        if translations.any?
          return self.find(translations.first.send("#{self.name.underscore.split("/").last}_id").to_i)
        else
          return nil
        end
      end
    end

    module InstanceMethods


      def get_attr(attr_name, locale = I18n.locale)
        locale_priorities = {en: [:en, :de, :ru, :uk], de: [:de, :en, :ru, :uk], ru: [:ru, :uk, :en, :de], uk: [:uk, :ru, :en, :de]}
        res = nil
        locale_priorities[locale.to_sym].each do |locale|
          res = self.translations_by_locale[locale].try(attr_name.to_sym)
          break if res.present?
        end

        return res
      end


    end
  end
end


ActiveRecord::Base.send(:extend, Cms::GlobalizeExtensions::ClassMethods)
#ActiveRecord::Base.send(:include, Cms::GlobalizeExtensions::InstanceMethods)