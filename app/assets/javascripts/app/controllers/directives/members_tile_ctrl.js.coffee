app.controller 'MembersTileCtrl', ($scope, $state, $position, Project, UserService, CurrentProject, ModalService) ->
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.deleteMember = (user) ->
    ModalService.confirm("Remove #{ user.firstName } #{ user.lastName }?").then ->
      CurrentProject.get().removeMember(user.id).then ->
        $state.go('members', {}, { reload: true })

  $scope.isOwner = ->
    $scope.currentUser.id == CurrentProject.get().ownerId