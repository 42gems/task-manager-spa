app.controller 'MembersTileCtrl', ($scope, $state, $position, Project, UserService, CurrentProject, ModalService) ->
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.deleteMember = (user) ->
    ModalService.confirm("Remove #{ user.firstName } #{ user.lastName }?").then ->
      CurrentProject.get().removeMember(user.id).then ->
        $state.go('members', {}, { reload: true })

  $scope.isManagable = ->
    $scope.currentUser.id == CurrentProject.get().ownerId

  $scope.isOwner = (member) ->
    member.id == CurrentProject.get().ownerId

  $scope.isRemovable = (member) ->
    !($scope.isOwner(member) || !$scope.isManagable())