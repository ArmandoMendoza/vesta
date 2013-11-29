jQuery ->
  $('#form-add-image').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('.uploader').append(data.context)
        data.submit()
      else
        data.context = $(tmpl("template-error", file))
        $('.uploader').append(data.context)
    progress: (e, data)->
      progress = parseInt(data.loaded / data.total * 100, 10)
      data.context.find('.progress-bar').css('width', progress + '%')
    done: (e, data)->
      data.context.remove()