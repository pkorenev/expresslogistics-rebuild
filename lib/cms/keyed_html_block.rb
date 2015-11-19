class Cms::KeyedHtmlBlock < Cms::HtmlBlock
  default_scope do
    where(attachable: nil).where.not(key: nil)
  end
end