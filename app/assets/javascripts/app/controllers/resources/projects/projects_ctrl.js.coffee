app.controller 'ProjectsCtrl', ($scope, $state, $timeout, Project, User, CurrentProject, ModalService) ->
  $scope.projects = []

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

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
    ModalService.confirm("Delete project #{ projct.title }?").then ->
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
