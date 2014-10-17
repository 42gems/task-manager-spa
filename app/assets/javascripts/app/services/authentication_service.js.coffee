app.factory 'AuthenticationService', ($window)->
  auth =
    isLoggedIn: $window.localStorage.taskManagerSpaToken?
  auth