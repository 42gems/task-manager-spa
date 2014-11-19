app.controller 'ProjectCtrl', ($scope, $q, Project, UserService, $stateParams, $state) ->
  $scope.currentUser = {}

  Project.get({ id: $stateParams.projectId }).then (results) ->
    $scope.project = results
    $scope.getCurrentUser()
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

  $scope.addMember = (member_id) ->
    $scope.project.addMember(member_id).then (response) ->
      console.log 'Invitation has been sent'
      i = $scope.usersForInvite.indexOf(user) for user in $scope.usersForInvite when user.id == member_id
      $scope.usersForInvite.splice(i, 1)
      $scope.selected = $scope.usersForInvite[0]
    , (error) ->
      console.log 'Could not send an invitation'

  $scope.getCurrentUser = ->
    UserService.getCurrentUser()
      .success (user) ->
        $scope.currentUser = user
        $scope.isOwner()
        $scope.isMember()

  $scope.isOwner = ->
    $scope.currentUser.isOwner = $scope.currentUser.id == $scope.project.ownerId

  $scope.isMember = ->
    isMember = false
    isMember = true for member in $scope.members when member.id == $scope.currentUser.id
    $scope.currentUser.isMember = isMember

  $scope.isManagable = ->
    $scope.currentUser.isOwner or $scope.currentUser.isMember
