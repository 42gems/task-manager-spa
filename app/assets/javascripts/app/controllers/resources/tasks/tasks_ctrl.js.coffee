app.controller 'TasksCtrl', ($scope, Task, CurrentProject) ->

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.delete = (task) ->
    task.delete().then (respone) ->
      console.log 'Task successfuly deleted'
      i = $scope.tasks.indexOf(task)
      $scope.tasks.splice(i, 1)
    , ->
      console.log 'Could not delete task'

  $scope.$on 'currentProject:updated', (event, data) ->
   $scope.currentProject = data
   $scope.fetchTasks()
