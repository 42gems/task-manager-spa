app.controller "TimetracksModalInstanceCtrl", ($scope, $modalInstance, $state, projectId, taskId, Timetrack) ->
  
  $scope.getTimetracks = (projectId, taskId) ->
    Timetrack.query({}, projectId: projectId, taskId: taskId).then (results) ->
      $scope.timetracks = results
    , ->
      console.log 'Could not fetch timetracks'

  $scope.initTimetrack = ->
    $scope.timetrack = new Timetrack(taskId: taskId)
    $scope.timetrack.startDate = new Date().toLocaleDateString('ca-iso8601')
    $scope.timetrack.comments_attributes = []
    $scope.comment = {}
    $scope.comment.timetrackId = $scope.timetrack.id
  
  $scope.getTimetracks(projectId, taskId)
  $scope.initTimetrack()

  $scope.save = (form)->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      for timetrack in $scope.timetracks
        timetrack.projectId = projectId
        timetrack.save().then (response) ->
          $modalInstance.close(response)
        , (error) ->
          $modalInstance.dismiss "error"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

  $scope.addTimetrack = (form) ->
    $scope.$broadcast('runCustomValidations')

    if form.$valid
      $scope.timetracks.push($scope.timetrack)
      $scope.timetrack.comments_attributes.push($scope.comment)
      $scope.initTimetrack()
    else
      console.log "Can not add timetrack"

  $scope.deleteTimetrack = (timetrack) ->
    timetrack.projectId = projectId
    $scope.timetracks.pop(timetrack)
    
    timetrack.delete().then ->
      console.log 'Timetrack successfuly deleted'
    , ->
      console.log 'Could not delete timetrack'