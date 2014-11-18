app.controller 'TasksCtrl', ($scope, $q, $stateParams, Task, Project, UserService, $modal) ->
  $scope.tasks = []

  Task.query({}, projectId: $stateParams.projectId).then (tasks) ->
    $scope.tasks = tasks

  Project.get({ id: $stateParams.projectId }).then (results) ->
    $scope.project = results
  , (error) ->
    console.log 'Could not fetch project'
  
  Project.members($stateParams.projectId).then (results) ->
    $scope.members = results
    $scope.isManagable()
  , (error) ->
    console.log 'Could not fetch members of a project'

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
      templateUrl: "tasks/modal_form.html"
      controller: "NewTaskModalInstanceCtrl"
    )
    modalInstance.result.then (task) ->
      $scope.tasks.push(task)
    , ->
      console.log "Modal dismissed"

  $scope.editTaskModal = (id) ->
    modalInstance = $modal.open(
      templateUrl: "tasks/modal_form.html"
      controller: "EditTaskModalInstanceCtrl"
      resolve:
        id: ->
          id
    )
    modalInstance.result.then (task) ->
      console.log 'Task has been successfuly updated'
      i = $scope.tasks.indexOf(tsk) for tsk in $scope.tasks when tsk.id == task.id
      $scope.tasks.splice(i, 1)
      $scope.tasks.push(task)
    , ->
      console.log "Modal dismissed"

  $scope.isManagable = ->
    UserService.getCurrentUser()
      .success (currentUser) ->
        isMember = false
        isMember = true for member in $scope.members when member.id == currentUser.id
        isOwner  = currentUser.id == $scope.project.ownerId
        $scope.tasks.isManagable = isOwner or isMember
