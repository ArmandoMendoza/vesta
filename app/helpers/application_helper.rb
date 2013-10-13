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

  def table_panel(title, class_table = "table")
    content_tag(:div, class: "panel panel-default") do
      content_tag(:div, title, class: "panel-heading") +
      content_tag(:table, class: class_table) do
        yield
      end
    end
  end
end