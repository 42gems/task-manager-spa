app.controller 'SignInCtrl', ($scope, $window, $state, UserService, AuthenticationService) ->
  $scope.logIn = (email, password) ->
    $scope.$broadcast('runCustomValidations')

    if $scope.SignInForm.$valid
      UserService.logIn(email, password)
        .success (data) ->
          AuthenticationService.isLoggedIn = true
          $window.localStorage.taskManagerSpaToken = data.auth_token
          $state.go('board')
        .error (data, status) ->
          $scope.errors = [data.error]