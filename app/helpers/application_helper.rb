module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def md(text, options={})
    html = RDiscount.new(text || "").to_html

    html = html.gsub(/<\/?p>/, '') if options[:no_p]

    return html.html_safe
  end

end
