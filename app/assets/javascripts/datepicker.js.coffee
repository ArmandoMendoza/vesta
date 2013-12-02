jQuery ->
  days = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado']
  months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto',
    'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

  default_options =
    format: 'd-m-Y'
    days: days
    months: months
    show_select_today: 'Hoy'
    lang_clear_date: 'Limpiar'

  $('.datepicker').Zebra_DatePicker default_options
