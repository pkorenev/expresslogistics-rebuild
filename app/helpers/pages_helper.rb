module PagesHelper
  def html_block_with_fallback(key, from_page_instance = false, &block)
    page_instance = nil
    html_block = nil
    if from_page_instance == true
      page_instance = @page
    elsif from_page_instance.is_a?(Cms::Page)
      page_instance = from_page_instance
    end

    page_instance.try do |p|
      html_block = p.try{|ph| ph.html_blocks.by_field(key).first }
    end

    if  (html_block || (html_block = Cms::KeyedHtmlBlock.by_key(key).first)) && (text = html_block.translations_by_locale[I18n.locale].try(&:content)) && text.present?
      return raw text
    end

    if block_given?
      yield
      #self.instance_eval(&block)

    end

    nil

  end
end
