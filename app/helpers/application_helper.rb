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

  def table_panel(title, button = false, *args)
    options = args.extract_options!
    options[:table_class] ||= "table table-condensed table-hover"
    content_header = content_tag(:span, title, class: "text-title-panel")
    if button
      options[:button_options] ||= {}
      content_header << content_tag(:div, table_link_to_new(options[:button_options]),
        style: "float:right")
    end
    content_tag(:div, class: "panel panel-default") do
      content_tag(:div, class: "panel-heading") do
        content_header
      end +
      content_tag(:table, class: options[:table_class]) do
        yield
      end
    end
  end

  def panel(title, button = false, *args)
    options = args.extract_options!
    content_header = content_tag(:span, title, class: "text-title-panel")
    if button
      options[:button_options] ||= {}
      content_header << content_tag(:div, table_link_to_new(options[:button_options]),
        style: "float:right")
    end
    content_tag(:div, class: "panel panel-default") do
      content_tag(:div, class: "panel-heading") do
        content_header
      end +
      content_tag(:div, class: "panel-body") do
        yield
      end
    end
  end

  def table_link_to_new(options)
    options[:text] ||= "Nuevo"
    options[:url] ||= "#"
    options[:class] ||= "btn btn-dark btn-xs"
    link_to options[:url], class: options[:class] do
      content_tag(:span, nil, class: 'glyphicon glyphicon-plus') + " " + options[:text]
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

  def button_form_to_back(text, url = :back )
    link_to text, url, class: 'btn btn-vesta btn-form col-md-5'
  end

  def submit_button(text = "Guardar")
    content_tag(:button, text, type: "submit", value: text, class: "btn btn-vesta btn-form col-md-6")
  end

  # HELPERS TASKS INTERFACE
  def link_to_change_complete(state, url)
    if state
      css_class = "glyphicon glyphicon-check"
      title = "Desmarcar como completada"
    else
      css_class = "glyphicon glyphicon-unchecked"
      title = "Marcar como completada"
    end
    link_to(url, class: 'mark-task', title: title, remote: true, method: :patch, data: { toggle: 'tooltip' }) do
      content_tag(:span, nil, class: css_class)
    end
  end

  def class_completed(state)
    "task-completed" if state
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