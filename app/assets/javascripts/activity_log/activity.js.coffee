$(document).ready ->
  $.fn.dataTable.ext.errMode = 'none'
  $('#example').DataTable
    ordering: false
  return

$('.send-bottom').click ->
  baby_value = $("select[name=baby-select]").val()
  assis_value = $("select[name=assistant-select]").val()
  status_value = $("select[name=status-select]").val()

  if baby_value == "0" and assis_value == "0" and status_value == "0"
    return alert('Debe selecccionar alguna de las opciones')
  else
    $.ajax
      type: "POST"
      url: "/get_activity_log"
      dataType: "JSON"
      data: {baby_id: baby_value, assistant_id: assis_value, status: status_value}
      success: (res) ->
        if res
          console.log res
        return
      error: ->
        alert "Occurio un error, refresa la pagina"