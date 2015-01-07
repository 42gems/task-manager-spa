app.controller 'MembersCtrl', ($scope, $state, $timeout, Project, User, UserService) ->
  $timeout ->
    $scope.currentUser = UserService.getCurrentUser()

    User.invitedMembers($scope.currentUser.id).then (results) ->
      $scope.members = results
    , (error) ->
      console.log 'Could not fetch invited users'
  , 300

  $scope.removeMember = (projct, member_id) ->
    project = new Project(projct)
    project.removeMember(member_id).then (response) ->
      $state.go('members', {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'
