app.controller 'ProfileCtrl', ($scope, UserService, MaskService) ->
  $scope.saveProfile = ->
    timer = MaskService.show 500
    $scope.user.save().then (response) ->
      UserService.setCurrentUser($scope.user)
      MaskService.hide timer
      window.history.back()
    , ->
      MaskService.hide timer

  $scope.goBack = ->
    window.history.back()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.user = angular.copy(data)