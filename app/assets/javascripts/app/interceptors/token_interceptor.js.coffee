app.factory 'TokenInterceptor', ($q, $window, AuthenticationService, $location) ->
  request: (config) ->
    config.headers ?= {}
    if $window.localStorage.taskManagerSpaToken
      config.headers.Authorization = 'Token token=' + $window.localStorage.taskManagerSpaToken
    config

  requestError: (rejection) ->
    $q.reject(rejection)

  response: (response) ->
    response || $q.when(response)

  responseError: (rejection) ->
    if rejection?.status == 401 && $window.localStorage.taskManagerSpaToken
      delete $window.localStorage.taskManagerSpaToken
      AuthenticationService.isLoggedIn.set false
      $location.path('/sign_in')
    $q.reject(rejection)