$.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

$(document).ready ->
  $.fn.dataTable.ext.errMode = 'none'
  table = $('#example').DataTable(columns: [
    {
      'name': 'Bebe'
      'data': 'Bebe'
    }
    {
      'name': 'Asistente'
      'data': 'Asistente'
    }
    {
      'name': 'Actividad'
      'data': 'Actividad'
    }
    {
      'name': 'Inicio'
      'data': 'Inicio'
    }
    {
      'name': 'Estatus'
      'data': 'Estatus'
    }
    {
      'name': 'Duracion'
      'data': 'Duracion'
    }
  ]
  ordering: false)
  $('.send-bottom').click ->
    baby_value = $("select[name=baby-select]").val()
    assis_value = $("select[name=assistant-select]").val()
    status_value = $("select[name=status-select]").val()

    if baby_value == "0" and assis_value == "0" and status_value == "0"
      return alert('Debe selecccionar alguna de las opciones')
    else
      $.ajax
        type: "POST"
        url: "/get_activities_log"
        dataType: "JSON"
        data: {baby_id: parseInt(baby_value), assistant_id: parseInt(assis_value), status: parseInt(status_value)}
        success: (data) ->
          if data
            console.log data
            table.clear().draw()
            console.log data.activities.length
            if data.activities.length == 0
              alert "No se encontraron registros, filtre nuevamente"
              return false
            else
              _data = []
              i = 0
              while i < data.activities.length
                if data.activities[i].stop_time == null
                  item = {}
                  item['Bebe'] = data.activities[i].baby_name
                  item['Asistente'] = data.activities[i].assistant_name
                  item['Actividad'] = data.activities[i].baby_name
                  item['Inicio'] = data.activities[i].start_time
                  item['Estatus'] = 'En progreso'
                  item['Duracion'] = '*'
                  _data.push(item)
                else
                  item = {}
                  item['Bebe'] = data.activities[i].baby_name
                  item['Asistente'] = data.activities[i].assistant_name
                  item['Actividad'] = data.activities[i].baby_name
                  item['Inicio'] = data.activities[i].start_time
                  item['Estatus'] = 'Terminada'
                  item['Duracion'] = "#{data.activities[i].duration} #{'minutos'}"
                  _data.push(item)

                i++
            table.rows.add(_data).draw()


          return
        error: ->
          alert "Occurio un error, refresca la pagina"
  return