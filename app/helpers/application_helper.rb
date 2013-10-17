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

  def table_panel(title, class_table = "table table-condensed")
    content_tag(:div, class: "panel panel-default") do
      content_tag(:div, title, class: "panel-heading") +
      content_tag(:table, class: class_table) do
        yield
      end
    end
  end

  def link_to_edit(text, *args)
    process_args = add_class(*args, " edit")
    process_args = add_options(*process_args, {title: text})
    link_to(*process_args) do
      "#{text}"
    end
  end

  def link_to_show(text, *args)
    process_args = add_class(*args, " show")
    process_args = add_options(*process_args, {title: text})
    link_to(*process_args) do
      "#{text}"
    end
  end

  private
    def add_class(*args, default_class)
      options = args.extract_options!
      options[:class].present? ?
        options[:class] << default_class : options[:class] = default_class.strip
      args << options
    end

    def add_options(*args, hash_options)
      options = args.extract_options!
      options.merge!(hash_options)
      args << options
    end

end