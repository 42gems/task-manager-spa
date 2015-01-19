app.controller 'TasksColumnCtrl', ($scope, $modal) ->

  $scope.delete = (task) ->
    task.delete().then (respone) ->
      console.log 'Task successfuly deleted'
      i = $scope.tasks.indexOf(task)
      $scope.tasks.splice(i, 1)
    , ->
      console.log 'Could not delete task'

  $scope.updateStatus = (updated_task, state)->
    updated_task.state = state
    updated_task.save()
    # finding an index of corresponding task from current scope
    i = $scope.tasks.indexOf(task) for task in $scope.tasks when task.id == updated_task.id
    $scope.tasks[i].state = state

  $scope.newTaskModal = ->
    modalInstance = $modal.open
      templateUrl: "tasks/modal_form.html"
      controller: "NewTaskModalInstanceCtrl"

    modalInstance.result.then (task) ->
      $scope.tasks.push(task)
    , ->
      console.log "Modal dismissed"

  $scope.editTaskModal = (id) ->
    modalInstance = $modal.open
      templateUrl: "tasks/modal_form.html"
      controller: "EditTaskModalInstanceCtrl"
      resolve:
        id: ->
          id

    modalInstance.result.then (edited_task) ->
      console.log 'Task has been successfuly updated'
      # finding an index of corresponding task from current scope
      i = $scope.tasks.indexOf(task) for task in $scope.tasks when task.id == edited_task.id
      $scope.tasks.splice(i, 1)
      $scope.tasks.push(edited_task)
    , ->
      console.log "Modal dismissed"

  $scope.timeLeft = (task) ->
    if task.estimatedTime > task.timeSpent
      task.estimatedTime - task.timeSpent
    else
      0
