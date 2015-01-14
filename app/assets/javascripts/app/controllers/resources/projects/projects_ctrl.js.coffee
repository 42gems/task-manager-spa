app.controller 'ProjectsCtrl', ($scope, $state, Project, User, UserService, CurrentProject, ProjectsService, ModalService) ->
  $scope.projects = []
  $scope.projects = ProjectsService.get() if ProjectsService.get()
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

  $scope.$on 'projects:updated', (event, data) ->
    $scope.projects = data

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
      if ProjectsService.get()
        ProjectsService.add(project)
      else
        ProjectsService.set([project])
      $state.go('projects', {}, { reload: true })
      console.log 'Project successfuly created'
    , (error) ->
      console.log 'Could not create a project'
      console.log error

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

  $scope.gotoDetails = (project) ->
    CurrentProject.set(project)
    $state.go('project')
