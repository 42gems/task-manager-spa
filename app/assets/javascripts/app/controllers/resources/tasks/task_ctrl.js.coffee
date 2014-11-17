app.controller 'TaskCtrl', ($scope, $q, $stateParams, Task, $state) ->

  Task.get({ projectId: $stateParams.projectId, id: $stateParams.taskId }).then (task) ->
    $scope.task = task
  , (error) ->
    console.log 'Could not fetch the task'

  $scope.save = (taskForm)->
    #running super validations
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.save().then (response) ->
        $state.go('project.tasks', {}, { reload: true })
        console.log 'Successfuly updated the task'
      , (error) ->
        console.log 'Could not save the task'
