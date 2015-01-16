app.controller 'MembersCtrl', ($scope, $state, Project, CurrentProject, UserService) ->

  $scope.fetchUsersForInvite = ->
    Project.usersForInvite($scope.currentProject.id).then (users) ->
      $scope.usersForInvite = users
      $scope.selected = $scope.usersForInvite[0]
    , ->
      console.log 'Could not fetch users for invite'

  $scope.updateContext = ->
    $scope.fetchUsersForInvite()

    Project.members($scope.currentProject.id).then (members) ->
      $scope.members = members
    , (error) ->
      console.log 'Could not fetch members of a project'

    Project.userRights($scope.currentProject.id).then (rights) ->
      $scope.isManagable = rights is 'owner'
    , (error) ->
      console.log 'Could not fetch members of a project'

  $scope.addMember = (member_id) ->
    $scope.currentProject.addMember(member_id).then (response) ->
      console.log 'Invitation has been sent'
      # getting index of corresponding member from local scope
      i = $scope.usersForInvite.indexOf(user) for user in $scope.usersForInvite when user.id == member_id
      $scope.usersForInvite.splice(i, 1)
      $scope.selected = $scope.usersForInvite[0]
    , ->
      console.log 'Could not send an invitation'

  $scope.removeMember = (member_id) ->
    $scope.currentProject.removeMember(member_id).then (response) ->
      # finding an index of corresponding member from current scope
      i = $scope.members.indexOf(member) for member in $scope.members when member_id == member.id
      $scope.members.splice(i, 1)
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()

  if CurrentProject.get()
    $scope.currentProject = CurrentProject.get()
    $scope.updateContext()
