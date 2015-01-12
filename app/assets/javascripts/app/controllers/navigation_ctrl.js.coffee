app.controller 'NavigationCtrl', ($scope, Project, CurrentProject, AuthenticationService) ->

  $scope.fetchProjectTimeStats = ->
    Project.timeStats($scope.selected.id).then (timeStats) ->
      $scope.projectTimeStats = timeStats
    , ->
      console.log 'Could not fetch time stats on current project'

  $scope.updateCurrentProject = ->
    CurrentProject.set($scope.selected)

  $scope.updateContext = ->
    Project.query({}).then (projects) ->
      $scope.projects = projects
      if CurrentProject.get()
        i = projects.indexOf(project) for project in projects when project.id == CurrentProject.get().id
        $scope.selected = projects[i]
      else
        $scope.selected = projects[0]
      $scope.updateCurrentProject()
      $scope.fetchProjectTimeStats()
    , ->
      console.log 'Could not fetch projects'

  $scope.$watch 'selected', ->
    $scope.updateCurrentProject()
    $scope.fetchProjectTimeStats() if $scope.selected

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.userFullName = "#{data.firstName} #{data.lastName}"
    $scope.updateContext()
