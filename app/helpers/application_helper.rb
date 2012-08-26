# encoding: UTF-8

module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Banco de Voluntariado de Lisboa"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end