app.controller "TasksModalInstanceCtrl", ($scope, $modalInstance, $stateParams, Task) ->

  $scope.ok = ->
    Task.$post('/api/projects/' + $stateParams.projectId + '/tasks', 
      title: task.title
      description: task.description
      project_id: task.projectId
    ).then (response) ->
      $modalInstance.close # result
      console.log 'Task successfuly created'
    , (error) ->
      $modalInstance.dismiss "error"
      console.log 'Could not create a task'
      console.log error

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
