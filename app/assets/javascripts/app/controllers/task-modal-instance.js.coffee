app.controller "TasksModalInstanceCtrl", ($scope, $modalInstance, $stateParams, Task) ->
  $scope.task = new Task(projectId: $stateParams.projectId)
  $scope.ok = ->
    $scope.task.create().then (response) ->
      $modalInstance.close response
      console.log 'Task successfuly created'
    , (error) ->
      $modalInstance.dismiss "error"
      console.log 'Could not create a task'
      console.log error

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
