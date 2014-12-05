app.controller "DatetimeRangeModalInstanceCtrl", ($scope, $modalInstance) ->
  $scope.range =
    from: new Date()
    to:   new Date()

  $scope.save = (form)->
    $modalInstance.close $scope.range
      
  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
