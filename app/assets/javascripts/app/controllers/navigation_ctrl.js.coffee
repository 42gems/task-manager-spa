app.controller 'NavigationCtrl', ($rootScope, $scope, Project, CurrentProject, ProjectsService, AuthenticationService, ModalService, $timeout) ->
  groups =
      owner: 'My Projects'
      member: 'Collaborated Projects'
      public: 'Public Projects'
  $scope.isLoggedIn = AuthenticationService.isLoggedIn.get()

  $scope.updateCurrentProject = ->
    CurrentProject.set($scope.selected)

  $scope.setSelected = ->
    if CurrentProject.get()
      i = $scope.projects.indexOf(project) for project in $scope.projects when project.id == CurrentProject.get().id
      $scope.selected = $scope.projects[i]
    else
      $scope.selected = $scope.projects[0]

  $scope.updateContext = ->
    Project.query({}).then (projects) ->
      $scope.projects = projects
      $scope.setSelected()
      $scope.updateCurrentProject()
      ProjectsService.set(projects)
    , ->
      console.log 'Could not fetch projects'

  $scope.groupNameFor = (type) ->
    groups[type]

  $scope.removeTask = (task) ->
    ModalService.confirm("Delete task #{task.title}?").then ->
      task.remove().then ->
        $rootScope.$broadcast('task:removed', task)

  $scope.$watch 'selected', ->
    $scope.updateCurrentProject()

  $scope.$on 'authentication:changed', (event, data) ->
    $scope.isLoggedIn = data

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.userFullName = data.fullName
    $scope.avatarUrl = data.imageUrl
    $scope.updateContext()

  $scope.$on 'currentProject:updateTimetracks', (event, data) ->
    $scope.updateContext()

  $scope.$on 'draggable:start', (event, data) ->
    $scope.showTrash = true
    $scope.$digest()

  $scope.$on 'draggable:end', (event, data) ->
    $scope.showTrash = false
    $timeout ->
      $scope.$digest()

