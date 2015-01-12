app.controller 'ProfileCtrl', ($scope, UserService) ->

  $scope.saveProfile = ->
    $scope.user.save().then (response) ->
      UserService.setCurrentUser($scope.user)
      window.history.back()

  $scope.goBack = ->
    window.history.back()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.user = angular.copy(data)
