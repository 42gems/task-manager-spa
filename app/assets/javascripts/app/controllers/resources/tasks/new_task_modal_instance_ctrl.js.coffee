app.controller "NewTaskModalInstanceCtrl", ($scope, $modalInstance, Task, CurrentProject) ->
  $scope.task = new Task( projectId: CurrentProject.get().id )

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.create().then (response) ->
        $modalInstance.close response
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
