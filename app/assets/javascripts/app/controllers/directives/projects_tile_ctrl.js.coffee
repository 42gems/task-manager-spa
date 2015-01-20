app.controller 'ProjectsTileCtrl', ($scope, $state, $position, Project, UserService, CurrentProject, ModalService) ->
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

  $scope.deleteProject = (projct) ->
    ModalService.confirm("Delete project #{ projct.title }?").then ->
      project = new Project(projct)
      project.delete().then (response) ->
        $state.go('projects', {}, { reload: true })
        console.log 'Project successfuly deleted'
      , (error) ->
        console.log 'Could not remove project'

  $scope.isManagable = (project) ->
    $scope.currentUser.id == project.ownerId

  $scope.isRounded = (project) ->
    'rounded' unless $scope.isManagable(project)