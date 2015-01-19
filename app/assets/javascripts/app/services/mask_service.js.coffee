app.factory 'MaskService', ($timeout) ->
  service =
    show: (delay, selector) ->
      selector = selector || 'body'
      delay = delay || 0
      timer = $timeout ->
        angular.element(selector).showMask()
      , delay
      timer.selector = selector
      timer
    hide: (timer) ->
      angular.element(timer.selector).hideMask()
      $timeout.cancel timer