app.controller 'NavigationCtrl', ($scope, Project, CurrentProject, AuthenticationService) ->

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
    , ->
      console.log 'Could not fetch projects'

  if AuthenticationService.isLoggedIn
    $scope.updateContext()

  $scope.$watch 'selected', ->
    $scope.updateCurrentProject()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.userFullName = "#{data.firstName} #{data.lastName}"
    $scope.updateContext()
