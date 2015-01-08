app.controller 'ProfileCtrl', ($scope, User, $state) ->
  User.current({}).then (data) ->
    $scope.user = data

  $scope.saveProfile = ->
    $scope.user.save().then (response) ->
      window.history.back()

  $scope.goBack = ->
    window.history.back()