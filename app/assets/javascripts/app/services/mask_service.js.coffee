app.factory 'MaskService', ($timeout) ->
  service =
    show: (delay, selector) ->
      selector = selector || 'body'
      delay = delay || 0
      opts = 'modal' if selector == 'body'
      timer = $timeout ->
        angular.element(selector).showBodyMask(opts)
      , delay
      timer.selector = selector
      timer
    hide: (timer) ->
      angular.element(timer.selector).hideBodyMask()
      $timeout.cancel timer