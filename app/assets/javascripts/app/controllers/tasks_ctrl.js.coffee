app.controller 'TasksCtrl', ($scope, $q, $stateParams, Task, $modal) ->
  $scope.tasks = []

  Task.query({}, projectId: $stateParams.projectId).then (tasks) ->
    $scope.tasks = tasks

  $scope.updateStatus = (task, state)->
    task.state = state
    task.save()

  $scope.openModal = ->
    modalInstance = $modal.open(
      templateUrl: "tasks/modalForm.html"
      controller: "TasksModalInstanceCtrl"
    )
    modalInstance.result.then (response) ->
      console.log response
    , ->
      console.log "Modal dismissed at: " + new Date()
