module ActivitiesHelper
  def percent_numbers_to(activity)
    ((activity.current_execution.percent +  1)..100).to_a
  end

  def popover_to_execution_form(execution, url)
    title = "Actualizar Ejecucion"
    content = render(partial: "execution_form", locals: { execution: execution, url: url })
    link_to("Actulizar", '#', id: "popover_to_execution",
      data: { placement: "top", html: true, toggle: "popover",
      content: content.gsub("\n", ""), title: "", "original-title" => title })
  end
end
