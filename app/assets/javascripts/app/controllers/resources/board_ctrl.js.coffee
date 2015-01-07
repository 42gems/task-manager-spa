app.controller 'BoardCtrl', ($scope, $timeout, CurrentProject, Task) ->
  $scope.tasks = []
  $scope.currentProject = CurrentProject.get() if CurrentProject.get()
  $scope.currentProject ||= {}

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $timeout ->
    $scope.fetchTasks()
  , 300

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.fetchTasks()
