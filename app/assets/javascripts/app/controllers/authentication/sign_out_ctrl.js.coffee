app.controller 'SignOutCtrl', ($scope, $window, $state, UserService, AuthenticationService) ->
  $scope.logOut = ->
    UserService.logOut()
      .success (data) ->
        AuthenticationService.isLoggedIn.set false
        $state.go('sign_in')
      .error (status, data) ->
        console.log data
        console.log status