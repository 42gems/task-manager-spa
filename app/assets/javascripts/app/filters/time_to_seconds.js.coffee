app.filter 'timeToSeconds', () ->
  (data) ->
    if typeof data is 'string' or data instanceof String
      timings =
        days: data.match /(\d+)d/i
        hours: data.match /(\d+)h/i
        minutes: data.match /(\d+)m/i

      for key of timings
        data = 0
        data = timings[key][1] if timings[key]
        timings[key] = parseInt(data, 10)

      days    = (timings.days * (8 * 60 * 60)) || 0
      hours   = (timings.hours * (60 * 60))    || 0
      minutes = (timings.minutes * 60)         || 0

      days + hours + minutes
    else
      data
