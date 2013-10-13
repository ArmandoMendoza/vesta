module ApplicationHelper

  def form_panel(title)
    content_tag(:div, class: "panel panel-default") do
      content_tag(:div, class: "panel-heading") do
        content_tag(:h3, title, class: "panel-title" )
      end +
      content_tag(:div, class: "panel-body") do
        yield
      end
    end
  end
end