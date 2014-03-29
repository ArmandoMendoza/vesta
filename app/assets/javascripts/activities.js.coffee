jQuery ->
  if $('#task_description').length > 0
    $('#task_description').keypress (e) ->
      if e.which == 13
        $('form#new_task').submit()