app.controller 'BoardCtrl', ($scope, Task, Project) ->

  $scope.fetchProjects = ->
    Project.get({ id: $scope.currentProject.id }).then (project) ->
      $scope.project = project
    , ->
      console.log 'Could not fetch project'

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.checkUserRights = ->
    Project.userRights($scope.currentProject.id).then (rights) ->
      $scope.isManagable = rights isnt 'public'
    , ->
      console.log 'Could not fetch members of a project'

  $scope.updateContext = ->
    $scope.fetchProjects()
    $scope.fetchTasks()
    $scope.checkUserRights()

  $scope.$on 'currentProject:updated', (event, data) ->
   $scope.currentProject = data
   $scope.updateContext()
