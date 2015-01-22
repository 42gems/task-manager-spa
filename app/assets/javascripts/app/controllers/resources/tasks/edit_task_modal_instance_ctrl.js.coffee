app.controller "EditTaskModalInstanceCtrl", ($scope, $modalInstance, Task, CurrentProject, Project, id) ->

  Task.get({ projectId: CurrentProject.get().id, id: id }).then (task) ->
    $scope.task = task
    Project.members(CurrentProject.get().id).then (members) ->
      task.assignee = member for member in members when member.id == task.assigneeId
      $scope.members = members.map (member) ->
          angular.extend(member, fullName: "#{member.firstName} #{member.lastName}")
  , ->
    console.log 'Could not fetch project'

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.save().then (task) ->
        $modalInstance.close(task)
        CurrentProject.updateTimetracks()
      , ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
