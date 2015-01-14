app.controller 'ProjectsCtrl', ($scope, $state, Project, User, UserService, CurrentProject, ProjectsService, ModalService) ->
  $scope.projects = []
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.myProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'owner'

  $scope.memberProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'member'

  $scope.publicProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'public'

  $scope.filterProjects = (projects) ->
    $scope.myProjects = $scope.myProjects(projects)
    $scope.memberProjects = $scope.memberProjects(projects)
    $scope.publicProjects = $scope.publicProjects(projects)

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

  if ProjectsService.get()
    $scope.projects = ProjectsService.get() 
    $scope.filterProjects($scope.projects)

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

  $scope.$on 'projects:updated', (event, data) ->
    $scope.projects = data
    $scope.filterProjects($scope.projects)
