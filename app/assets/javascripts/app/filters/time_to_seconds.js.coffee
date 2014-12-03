app.filter 'timeToSeconds', () ->

  (data) ->
    if typeof data is 'string' or data instanceof String
      timings = data.match /\d+/g
      unless timings is null
        timings = timings.map Number

        days    = (timings[0] * (24 * 60 * 60)) || 0
        hours   = (timings[1] * (60 * 60))      || 0
        minutes = (timings[2] * 60)             || 0
        seconds =  timings[3]                   || 0

        days + hours + minutes + seconds
      else
        0
    else
      data
