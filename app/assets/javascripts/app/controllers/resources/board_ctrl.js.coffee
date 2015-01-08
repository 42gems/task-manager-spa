app.controller 'BoardCtrl', ($scope, Task) ->
  $scope.tasks = []

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.fetchTasks()
