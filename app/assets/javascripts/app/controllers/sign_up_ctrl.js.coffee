app.controller 'SignUpCtrl', ($scope, User, $state) ->
  $scope.user = new User()

  $scope.signUp = (form) ->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      $scope.user.create().then (response) ->
        console.log 'User successfully created'
        $state.go 'sign_in'
      , (error) ->
        console.log 'Could not create user'
