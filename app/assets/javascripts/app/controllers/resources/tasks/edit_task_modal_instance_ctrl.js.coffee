app.controller "EditTaskModalInstanceCtrl", ($scope, $modalInstance, $stateParams, Task, id) ->

  Task.get({ projectId: $stateParams.projectId, id: id }).then (result) ->
    $scope.task = result
  , ->
    console.log 'Could not fetch project'

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.save().then (response) ->
        $modalInstance.close response
      , ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
