app.controller 'NavigationCtrl', ($scope, Project, CurrentProject, ProjectsService, AuthenticationService) ->

  $scope.fetchProjectTimeStats = ->
    Project.timeStats($scope.selected.id).then (timeStats) ->
      $scope.projectTimeStats = timeStats
    , ->
      console.log 'Could not fetch time stats on current project'

  $scope.updateCurrentProject = ->
    CurrentProject.set($scope.selected)

  $scope.setSelected = ->
    if CurrentProject.get()
      i = $scope.projects.indexOf(project) for project in $scope.projects when project.id == CurrentProject.get().id
      $scope.selected = $scope.projects[i]
    else
      $scope.selected = $scope.projects[0]

  $scope.updateContext = ->
    if ProjectsService.get()
      $scope.projects = ProjectsService.get()
      $scope.setSelected()
      $scope.updateCurrentProject()
      $scope.fetchProjectTimeStats()
    else
      Project.query({}).then (projects) ->
        $scope.projects = projects
        $scope.setSelected()
        $scope.updateCurrentProject()
        $scope.fetchProjectTimeStats()
        ProjectsService.set(projects)
      , ->
        console.log 'Could not fetch projects'

  $scope.$watch 'selected', ->
    $scope.updateCurrentProject()
    $scope.fetchProjectTimeStats() if $scope.selected

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.userFullName = "#{data.firstName} #{data.lastName}"
    $scope.updateContext()

