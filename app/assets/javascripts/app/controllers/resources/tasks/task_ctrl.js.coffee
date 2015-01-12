app.controller 'TaskCtrl', ($scope, $state, $stateParams, Task) ->

  $scope.fetchTask = ->
    Task.get({ projectId: $scope.currentProject.id, id: $stateParams.taskId }).then (task) ->
      $scope.task = task
    , ->
      console.log 'Could not fetch the task'

  $scope.save = (taskForm)->
    $scope.$broadcast('runCustomValidations')

    if taskForm.$valid
      $scope.task.save().then (response) ->
        $state.go('tasks', {}, { reload: true })
        console.log 'Successfuly updated the task'
      , ->
        console.log 'Could not save the task'

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.fetchTask()
