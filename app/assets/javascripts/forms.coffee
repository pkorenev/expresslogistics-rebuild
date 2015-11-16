$("form.ajax-submit").on "submit", (e)->
  e.preventDefault()
  $form = $(this)
  form_height = $form.height()
  data = $form.serializeArray()
  url = $form.attr("action")
  method = $form.attr("method")

  $form_content = $form.find(".form-content")
  $form_content.hide()

  $form_preloader = $form.find(".preloader")
  #$form_preloader.height(form_height)
  $form_preloader.fadeIn()
  $success_block = $form.find(".success")
  #$success_block.height(form_height)
  $form.height(form_height)


  $.ajax(
    url: url
    data: data
    type: method
    success: ()->
      $form_preloader.hide()



      $success_block.fadeIn()
  )