app.controller "TimetracksModalInstanceCtrl", ($scope, $modalInstance, projectId, taskId, Timetrack) ->
  
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

  $scope.save = (form)->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      $scope.timetrack.create().then (response) ->
        $modalInstance.close(response)
      , (error) ->
        $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

  $scope.deleteTimetrack = (timetrack) ->
    timetrack.projectId = projectId
    
    timetrack.delete().then ->
      $scope.timetracks.pop(timetrack)
      console.log 'Timetrack successfuly deleted'
    , ->
      console.log 'Could not delete timetrack'
