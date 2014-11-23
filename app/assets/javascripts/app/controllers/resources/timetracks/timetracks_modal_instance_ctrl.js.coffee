app.controller "TimetracksModalInstanceCtrl", ($scope, $modalInstance, projectId, taskId, Timetrack) ->
  
  $scope.save = (form)->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      $scope.timetrack.create().then (response) ->
        $modalInstance.close(response)
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

  $scope.getTimetracks = (projectId, taskId) ->
    Timetrack.query({}, projectId: projectId, taskId: taskId).then (results) ->
      $scope.timetracks = results
    , ->
      console.log 'Could not fetch timetracks'

  $scope.init = ->
    $scope.getTimetracks(projectId, taskId)
    $scope.timetrack = new Timetrack(projectId: projectId, taskId: taskId)
    $scope.timetrack.start_date = new Date().toLocaleDateString('ca-iso8601')

  $scope.init()