app.controller 'ProjectsCtrl', ($scope, $q, Project, User, UserService, $state) ->
  $scope.currentUser = {}

  Project.query({}).then (results) ->
    $scope.projects = results
    $scope.getCurrentUser()
  , (error) ->
    console.log 'Could not fetch projects'
  
  User.query({}, 'invited_members').then (results) ->
    $scope.members = results
  , (error) ->
    console.log 'Could not fetch invited users'

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
    project = new Project(projct)
    project.delete().then (response) ->
      $state.go('projects', {}, { reload: true })
      console.log 'Project successfuly deleted'
    , (error) ->
      console.log 'Could not remove project'

  $scope.removeMember = (projct, member_id) ->
    project = new Project(projct)
    project.removeMember(member_id).then (response) ->
      $state.go('members', {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'

  $scope.getCurrentUser = ->
    UserService.getCurrentUser()
      .success (data) ->
        $scope.currentUser = data

  $scope.isManagable = (project) ->
    $scope.currentUser.id == project.ownerId
