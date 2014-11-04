app.controller 'TasksCtrl', ($scope, $q, $stateParams, Task, $modal) ->
  $scope.tasks = []

  Task.query({}, projectId: $stateParams.projectId).then (tasks) ->
    $scope.tasks = tasks

  $scope.delete = (task) ->
    task.delete().then (respone) ->
      $scope.tasks.pop(task)
      console.log 'Task successfuly deleted'
    , (error) ->
      console.log 'Could not delete task'
      console.log error

  $scope.updateStatus = (task, state)->
    task.state = state
    task.save()

  $scope.newTaskModal = ->
    modalInstance = $modal.open(
      templateUrl: "tasks/modalForm.html"
      controller: "NewTaskModalInstanceCtrl"
    )
    modalInstance.result.then (task) ->
      $scope.tasks.push(task)
    , ->
      console.log "Modal dismissed"

  $scope.editTaskModal = (id) ->
    modalInstance = $modal.open(
      templateUrl: "tasks/modalForm.html"
      controller: "EditTaskModalInstanceCtrl"
      resolve:
        id: ->
          id
    )
    modalInstance.result.then (task) ->
      console.log 'Task has been successfuly updated'
    , ->
      console.log "Modal dismissed"
