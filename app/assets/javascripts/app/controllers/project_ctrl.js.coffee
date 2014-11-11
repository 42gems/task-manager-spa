app.controller 'ProjectCtrl', ($rootScope, $scope, $q, Project, UserService, $stateParams, $state) ->

  Project.get({ id: $stateParams.projectId }).then (results) ->
    $scope.project = results
    $scope.isManagable()
  , (error) ->
    console.log 'Could not fetch project'

  Project.members($stateParams.projectId).then (results) ->
    $scope.members = results
  , (error) ->
    console.log 'Could not fetch members of a project'

  Project.usersForInvite($stateParams.projectId).then (results) ->
    $scope.usersForInvite = results  
    $scope.selected = $scope.usersForInvite[0]
  , (error) ->
    console.log 'Could not fetch users for invite'

  $scope.saveProject = ->
    $scope.project.save().then (response) ->
      console.log 'Project successfuly updated'
      $state.go('project', {}, { reload: true })
    , (error) ->
      console.log 'Could not update the project'

  $scope.delete = ->
    $scope.project.delete().then (respone) ->
      console.log 'Project successfuly deleted'
      $state.go 'projects'
    , (error) ->
      console.log 'Could not delete the project'

  $scope.removeMember = (member_id) ->
    $scope.project.removeMember(member_id).then (response) ->
      $state.go($state.current, {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'

  $scope.sendInvite = (member_id) ->
    $scope.project.sendInvite(member_id).then (response) ->
      console.log 'Invitation has been sent'
    , (error) ->
      console.log 'Could not send an invitation'

  $scope.isManagable = ->
    UserService.getCurrentUser()
      .success (currentUser) ->
        $scope.project.isManagable = currentUser.id == $scope.project.ownerId
