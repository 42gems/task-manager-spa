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

  $scope.saveProject = (projct) ->
    projct.ownerId = $scope.currentUser.id
    project = new Project(projct)
    project.save().then (response) ->
      console.log 'Project successfuly updated'
      $scope.toggleInputs(projct)
    , (error) ->
      console.log 'Could not update a project'
      console.log error
      $scope.toggleInputs(project)

  $scope.isManagable = (project) ->
    $scope.currentUser.id == project.ownerId

  $scope.isRounded = (project) ->
    'rounded' unless $scope.isManagable(project)

  $scope.reversedInputState = (project) ->
    if project.inputState is 'hidden'
      ''
    else
      'hidden'

  $scope.toggleInputs = (project) ->
    if project.inputState is 'hidden'
      project.inputState = ''
    else
      project.inputState = 'hidden'
