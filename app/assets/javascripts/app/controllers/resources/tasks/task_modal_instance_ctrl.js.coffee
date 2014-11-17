app.controller "TasksModalInstanceCtrl", ($scope, $modalInstance, $stateParams, Task) ->
  $scope.task = new Task(projectId: $stateParams.projectId)
  $scope.save = (taskForm)->
    #running super validations
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.create().then (response) ->
        $modalInstance.close response
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
