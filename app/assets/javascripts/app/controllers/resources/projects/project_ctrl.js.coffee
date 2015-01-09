app.controller 'ProjectCtrl', ($scope, $state, Project, ModalService) ->
  $scope.currentUser = {}

  $scope.fetchMembers = ->
    Project.members($scope.currentProject.id).then (response) ->
      $scope.members = response
    , ->
      console.log 'Could not fetch members of a project'

  $scope.fetchProjects = ->
    Project.get({ id: $scope.currentProject.id }).then (response) ->
      $scope.project = response
    , ->
      console.log 'Could not fetch project'

  $scope.fetchUsersForInvite = ->
    Project.usersForInvite($scope.currentProject.id).then (response) ->
      $scope.usersForInvite = response
      $scope.selected = $scope.usersForInvite[0]
    , ->
      console.log 'Could not fetch users for invite'

  $scope.checkUserRights = ->
    Project.userRights($scope.currentProject.id).then (response) ->
      $scope.currentUser.isOwner = response is 'owner'
      $scope.currentUser.isMember = response is 'member'
      $scope.isManagable = response isnt 'public'

  $scope.updateContext = ->
    $scope.fetchMembers()
    $scope.fetchProjects()
    $scope.fetchUsersForInvite()
    $scope.checkUserRights()

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()

  $scope.saveProject = ->
    $scope.project.save().then (response) ->
      console.log 'Project successfuly updated'
      $state.go('project', {}, { reload: true })
    , ->
      console.log 'Could not update the project'

  $scope.delete = ->
    ModalService.confirm("Delete project #{ $scope.project.title }?").then ->
      $scope.project.delete().then (response) ->
        console.log 'Project successfuly deleted'
        $state.go 'projects'
      , ->
        console.log 'Could not delete the project'

  $scope.removeMember = (member_id) ->
    $scope.project.removeMember(member_id).then (response) ->
      $state.go($state.current, {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , ->
      console.log 'Could not remove member'

  $scope.addMember = (member_id) ->
    $scope.project.addMember(member_id).then (response) ->
      console.log 'Invitation has been sent'
      i = $scope.usersForInvite.indexOf(user) for user in $scope.usersForInvite when user.id == member_id
      $scope.usersForInvite.splice(i, 1)
      $scope.selected = $scope.usersForInvite[0]
    , ->
      console.log 'Could not send an invitation'
