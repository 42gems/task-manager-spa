app.controller 'SignUpCtrl', ($scope, User, $state, UserService, AuthenticationService, $window) ->
  $scope.user = new User()

  $scope.signUp = (form) ->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      UserService.signup($scope.user).then (data) ->
        AuthenticationService.isLoggedIn.set true
        $window.localStorage.taskManagerSpaToken = data.authToken
        $state.go('board')
      , (response) ->
        $scope.errors = response.data