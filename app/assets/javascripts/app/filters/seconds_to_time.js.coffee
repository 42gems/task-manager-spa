app.filter 'secondsToTime', () ->

  (data) ->
    if data == parseInt(data)
      days = Math.floor(data / (60 * 60 * 24))
      
      divisor_for_hours = data % (60 * 60 * 24)
      hours = Math.floor(divisor_for_hours / (60 * 60))
      
      divisor_for_minutes = data % (60 * 60)
      minutes = Math.floor(divisor_for_minutes / 60)
      
      divisor_for_seconds = divisor_for_minutes % 60
      seconds = Math.ceil(divisor_for_seconds)
      
      days + 'd ' + hours + 'h ' + minutes + 'm ' + seconds + 's'
    else
      data
