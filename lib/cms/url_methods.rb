module Cms
  module UrlMethods
    def auto_build_url_fragment
      locale = self.locale.to_sym
      locale = :ru if locale == :uk
      self.url_fragment = I18n.with_locale(locale){ self.name.parameterize } if self.url_fragment.blank?
    end


  end

  module ArticleMethods
    module ClassMethods

    end

    module InstanceMethods
      def initialize_released_at
        self.released_at = self.created_at if self.released_at.blank?
      end
    end
  end
end