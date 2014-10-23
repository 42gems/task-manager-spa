app.controller 'TasksCtrl', ($scope, $q, $stateParams, Task) ->
  $scope.tasks = []

  Task.query({}, projectId: $stateParams.projectId).then (tasks) ->
    $scope.tasks = tasks

  $scope.updateStatus = (task, state)->
    task.state = state
    task.save()