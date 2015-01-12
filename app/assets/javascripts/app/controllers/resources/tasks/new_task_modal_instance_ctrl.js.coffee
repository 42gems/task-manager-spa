app.controller "NewTaskModalInstanceCtrl", ($scope, $modalInstance, Task, CurrentProject) ->
  $scope.task = new Task( projectId: CurrentProject.get().id )

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.create().then (task) ->
        $modalInstance.close(task)
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
