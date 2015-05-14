app.controller 'ProjectsCtrl', ($scope, $state, Project, User, UserService, CurrentProject, ProjectsService) ->
  $scope.projects = []
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.filterMyProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'owner'

  $scope.filterMemberProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'member'

  $scope.filterPublicProjects = (projects) ->
    projects.filter (project) ->
      project.type == 'public'

  $scope.filterProjects = (projects) ->
    $scope.myProjects = $scope.filterMyProjects(projects)
    $scope.memberProjects = $scope.filterMemberProjects(projects)
    $scope.publicProjects = $scope.filterPublicProjects(projects)

  $scope.saveProject = ->
    $scope.project.ownerId = $scope.currentUser.id
    project = new Project($scope.project)
    project.save().then (response) ->
      if ProjectsService.get()
        ProjectsService.add(project)
      else
        ProjectsService.set([project])
      $state.go('projects')
      console.log 'Project successfuly created'
    , (error) ->
      console.log 'Could not create a project'
      console.log error

  $scope.initInputStates = ->
    for project in $scope.projects
      project.inputState = 'hidden'

  if ProjectsService.get()
    $scope.projects = ProjectsService.get()
    $scope.filterProjects($scope.projects)
    $scope.initInputStates()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

  $scope.$on 'projects:updated', (event, data) ->
    $scope.projects = data
    $scope.filterProjects($scope.projects)
    $scope.initInputStates()
