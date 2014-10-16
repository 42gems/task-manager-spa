app.controller 'SignInCtrl', ($scope, $window, $state, UserService, AuthenticationService) ->
  $scope.logIn = (email, password) ->
    if email && password
      UserService.logIn(email, password)
        .success (data) ->
          AuthenticationService.isLoggedIn = true
          $window.sessionStorage.token = data.auth_token
          $state.go('home')
        .error (status, data) ->
          console.log data
          console.log status