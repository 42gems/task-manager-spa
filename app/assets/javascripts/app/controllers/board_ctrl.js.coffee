app.controller 'BoardCtrl', ($scope, $state, Task, Project, CurrentProject, ProjectsService) ->

  if ProjectsService.get()
    $scope.projects = ProjectsService.get()
    $state.go('projects.new') if $scope.projects.length == 0
  else
    Project.query({}).then (projects) ->
      $scope.projects = projects
      $state.go('projects.new') if $scope.projects.length == 0
    , ->
      console.log 'Could not fetch projects'

  $scope.fetchTasks = ->
    Task.query({}, projectId: $scope.currentProject.id).then (tasks) ->
      $scope.tasks = tasks

  $scope.checkUserRights = ->
    Project.userRights($scope.currentProject.id).then (rights) ->
      $scope.isManagable = rights isnt 'public'
    , ->
      console.log 'Could not fetch members of a project'

  $scope.updateContext = ->
    $scope.fetchTasks()
    $scope.checkUserRights()

  $scope.$on 'currentProject:updated', (event, data) ->
   $scope.currentProject = data
   $scope.updateContext()

  if CurrentProject.get()
    $scope.currentProject = CurrentProject.get()
    $scope.updateContext()
