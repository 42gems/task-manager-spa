app.filter 'secondsToTime', () ->
  (data, precision) ->
    if data == parseInt(data)
      days = Math.floor(data / (60 * 60 * 8))
      
      divisor_for_hours = data % (60 * 60 * 8)
      hours = Math.floor(divisor_for_hours / (60 * 60))
      
      divisor_for_minutes = data % (60 * 60)
      minutes = Math.floor(divisor_for_minutes / 60)
      
      time = 
        days:    if days > 0 then days + 'd ' else ''
        hours:   if hours > 0 then hours + 'h ' else ''
        minutes: if minutes > 0 then minutes + 'm ' else ''
      
      result = switch precision
        when 'd' then time.days
        when 'h' then time.days + time.hours
        else time.days + time.hours + time.minutes
    else
      data
