app.factory 'AuthenticationService', ($window)->
  auth =
    isLoggedIn: $window.sessionStorage.token?
  auth