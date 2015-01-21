app.factory 'AuthenticationService', ($window, $rootScope)->
  loggedIn = $window.localStorage.taskManagerSpaToken?
  auth =
    isLoggedIn:
      get: -> loggedIn
      set: (value) ->
        if value != loggedIn
          loggedIn = value
          delete $window.localStorage.taskManagerSpaToken
          $rootScope.$broadcast('authentication:changed', value)
  auth