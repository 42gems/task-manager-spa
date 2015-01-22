app.controller "NewTaskModalInstanceCtrl", ($scope, $modalInstance, Task, CurrentProject, Project, UserService) ->
  $scope.task = new Task( projectId: CurrentProject.get().id, assignee: UserService.getCurrentUser() )

  Project.members(CurrentProject.get().id).then (members) ->
      $scope.members = members.map (member) ->
          angular.extend(member, fullName: "#{member.firstName} #{member.lastName}")

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.create().then (task) ->
        $modalInstance.close(task)
        CurrentProject.updateTimetracks()
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
