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
      content_tag(:div, class: "progress-bar progress-bar-warning", role: "progressbar", "aria-valuemin" => 0,
      "aria-valuemax" => 100, "aria-valuenow" => percent, style: "width: #{percent}%") do
        content_tag(:span, "#{percent}% Ejecutado", class: "sr-only")
      end
    end
  end

  def activity_parent(activity)
    activity.has_parent? ? activity.parent.name : "Ninguna"
  end
end
