jQuery ->
  $('#new_image').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $('<p/>').text('Uploading...').appendTo(document.body)
        # data.submit()
      else
        $('<p/>').text("Error en formato de archivo #{file.name}").appendTo(document.body)
    done: (e, data) ->
      data.context.text('Upload finished.')
    progressall: (e, data)->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.progress-bar').css('width', progress + '%')