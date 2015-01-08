app.controller 'TasksCtrl', ($scope, $modal, Task, Project) ->

  $scope.fetchProjects = ->
    Project.get({ id: $scope.currentProject.id }).then (results) ->
      $scope.project = results
    , ->
      console.log 'Could not fetch project'

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.fetchMembers = ->
    Project.membersWithUserRights($scope.currentProject.id).then (results) ->
      $scope.members = results.members
      $scope.isManagable = results.userRights isnt 'public'
    , ->
      console.log 'Could not fetch members of a project'

  $scope.updateContext = ->
    $scope.fetchProjects()
    $scope.fetchTasks()
    $scope.fetchMembers()

  $scope.delete = (task) ->
    task.delete().then (respone) ->
      console.log 'Task successfuly deleted'
      i = $scope.tasks.indexOf(task)
      $scope.tasks.splice(i, 1)
    , ->
      console.log 'Could not delete task'

  $scope.updateStatus = (task, state)->
    task.state = state
    task.save()
    i = $scope.tasks.indexOf(tsk) for tsk in $scope.tasks when tsk.id == task.id
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
    
    modalInstance.result.then (task) ->
      console.log 'Task has been successfuly updated'
      i = $scope.tasks.indexOf(tsk) for tsk in $scope.tasks when tsk.id == task.id
      $scope.tasks.splice(i, 1)
      $scope.tasks.push(task)
    , ->
      console.log "Modal dismissed"

  $scope.$on 'currentProject:updated', (event, data) ->
   $scope.currentProject = data
   $scope.updateContext()

  $scope.$on 'currentUser:updated', (event, data) ->
   $scope.currentUser = data
