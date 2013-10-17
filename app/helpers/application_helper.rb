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

  def link_to_new(text, *args)
    process_args = add_class(args, " btn btn-small")
    process_args = add_options(process_args, {title: "HOLA"})
    link_to(*process_args) do
      content_tag(:i, nil, class: "icon-plus-sign") + " #{text}"
    end
  end

  private
    def add_class(args, default_class)
      options = args.last
      options[:class].present? ?
        options[:class] << default_class : options[:class] = default_class.strip
      args
    end

    def add_options(args, hash_options)
      options = args.last
      options.merge!(hash_options)
      args
    end

end