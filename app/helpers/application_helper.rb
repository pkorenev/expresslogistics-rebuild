module ApplicationHelper
  def seo_title
    title = @title
    title = meta_data[:title] if title.blank?
  end

  def seo_keywords
    keywords = @keywords
    keywords = meta_data[:keywords] if keywords.blank?
  end

  def seo_description
    description = @description
    description = meta_data[:description] if description.blank?
  end



  def meta_data
    @meta_data || @page.try(&:seo_tags) || {}
  end

  def render_seo_tags
    html = ""
    html += content_tag(:title, seo_title)
    html += content_tag(:meta, "",name: "keywords", content: seo_keywords) if seo_keywords.present?
    html += content_tag(:meta, "", name: "description", content: seo_description) if seo_description.present?

    raw(html)
  end
end
