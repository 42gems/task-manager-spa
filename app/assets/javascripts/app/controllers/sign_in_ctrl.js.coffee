app.controller 'SignInCtrl', ($rootScope, $scope, $window, $state, UserService, AuthenticationService) ->
  $scope.logIn = (email, password) ->
    if email && password
      UserService.logIn(email, password)
        .success (data) ->
          AuthenticationService.isLoggedIn = true
          $window.localStorage.taskManagerSpaToken = data.auth_token
          $state.go('home')
          $scope.currentUser()
        .error (status, data) ->
          console.log data
          console.log status

  $scope.currentUser = ->
    UserService.currentUser()
      .success (data) ->
        $rootScope.currentUser = data
      .error (status, data) ->
        console.log data
        console.log status
