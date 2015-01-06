app.controller 'BoardCtrl', ($scope, CurrentProject, Task) ->
  $scope.tasks = []
  $scope.currentProject = CurrentProject.get() if CurrentProject.get()
  $scope.currentProject ||= {}

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.fetchTasks()

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.fetchTasks()
