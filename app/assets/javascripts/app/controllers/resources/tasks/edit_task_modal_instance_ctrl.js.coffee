app.controller "EditTaskModalInstanceCtrl", ($scope, $modalInstance, Task, CurrentProject, id) ->

  Task.get({ projectId: CurrentProject.get().id, id: id }).then (task) ->
    $scope.task = task
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
