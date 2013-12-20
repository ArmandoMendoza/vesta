module ActivitiesHelper
  def percent_numbers_to(activity)
    ((activity.current_execution.percent +  1)..100).to_a
  end

  def popover_to_execution_form(execution, url)
    title = "Actualizar Ejecucion"
    content = render(partial: "execution_form", locals: { execution: execution, url: url })
    link_to("Actualizar", '#', id: "popover_to_execution",
      data: { placement: "top", html: true, toggle: "popover",
      content: content.gsub("\n", ""), title: "", "original-title" => title })
  end

  def progress_bar_of_execution(percent)
    content_tag(:div, class: "progress", style: "height: 10px") do
      content_tag(:div, class: "progress-bar progress-bar-vesta", role: "progressbar", "aria-valuemin" => 0,
      "aria-valuemax" => 100, "aria-valuenow" => percent, style: "width: #{percent}%") do
        content_tag(:span, "#{percent}% Ejecutado", class: "sr-only")
      end
    end
  end

  def activity_parent(activity)
    activity.has_parent? ? activity.parent.name : "Ninguna"
  end

  def thumb_link(image, index)
    css_style = index > 2 ? "display: none;" : "display: inline;"
    content_tag(:div, style: css_style) do
      link_to(image.image_file.url, rel: "prettyPhoto[pp_gal]", title: image.description) do
        image_tag(image.image_file.index_thumb.url)
      end
    end
  end
end
