app.factory 'TokenInterceptor', ($q, $window, AuthenticationService, $location) ->
  request: (config) ->
    config.headers ?= {}
    if $window.sessionStorage.token
      config.headers.Authorization = 'Token token=' + $window.sessionStorage.token
    config

  requestError: (rejection) ->
    $q.reject(rejection)

  response: (response) ->
    response || $q.when(response)

  responseError: (rejection) ->
    if rejection?.status == 401 && $window.sessionStorage.token
      delete $window.sessionStorage.token
      AuthenticationService.isLoggedIn = false
      $location.path('/sign_in')
    $q.reject(rejection)