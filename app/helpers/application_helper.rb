module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def md(content)
    MdPreview::CustomParser.parse(content)
  end

end
