app.controller 'ProjectsCtrl', ($scope, $state, $timeout, Project, User, UserService, CurrentProject, $modal) ->
  $scope.projects = []

  $timeout ->
    $scope.currentUser = UserService.getCurrentUser()
  , 300

  Project.query({}).then (results) ->
    $scope.projects = results
  , (error) ->
    console.log 'Could not fetch projects'

  $scope.myProjects = ->
    $scope.projects.filter (project) ->
      project.type == 'owner'

  $scope.memberProjects = ->
    $scope.projects.filter (project) ->
      project.type == 'member'

  $scope.publicProjects = ->
    $scope.projects.filter (project) ->
      project.type == 'public'

  $scope.saveProject = ->
    $scope.project.ownerId = $scope.currentUser.id
    project = new Project($scope.project)
    project.save().then (response) ->
      $state.go('projects', {}, { reload: true })
      console.log 'Project successfuly created'
    , (error) ->
      console.log 'Could not create a project'
      console.log error

  $scope.deleteProject = (projct) ->
    modalInstance = $modal.open(
      templateUrl: 'modal/confirm.html'
      controller: 'ModalConfirmCtrl'
      size: 'sm'
      resolve:
        caption: -> "Delete project #{ projct.title }?"
    );
    modalInstance.result.then ->
      project = new Project(projct)
      project.delete().then (response) ->
        $state.go('projects', {}, { reload: true })
        console.log 'Project successfuly deleted'
      , (error) ->
        console.log 'Could not remove project'

  $scope.isManagable = (project) ->
    $scope.currentUser.id == project.ownerId

  $scope.changeContext = (project) ->
    CurrentProject.set(project)
    $state.go('board')
