app.controller 'NavigationCtrl', ($scope, Project, CurrentProject, AuthenticationService) ->

  $scope.updateCurrentProject = ->
    CurrentProject.set($scope.selected)

  $scope.updateContext = ->
    Project.query({}).then (data) ->
      $scope.projects = data
      if CurrentProject.get()
        i = data.indexOf(project) for project in data when project.id == CurrentProject.get().id
        $scope.selected = data[i]
      else
        $scope.selected = data[0]
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
