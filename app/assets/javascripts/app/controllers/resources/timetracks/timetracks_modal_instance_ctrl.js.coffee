app.controller "TimetracksModalInstanceCtrl", ($scope, $modalInstance, projectId, taskId, currentUser, Timetrack) ->
  
  $scope.getTimetracks = (projectId, taskId) ->
    Timetrack.query({}, projectId: projectId, taskId: taskId).then (results) ->
      $scope.timetracks = results
    , ->
      console.log 'Could not fetch timetracks'

  $scope.initTimetrack = ->
    $scope.timetrack = new Timetrack(taskId: taskId, userId: currentUser.id)
    $scope.timetrack.startDate = new Date().toLocaleDateString('ca-iso8601')
    $scope.timetrack.comments_attributes = []
    $scope.comment = {}
    $scope.comment.userId = currentUser.id
    $scope.comment.timetrackId = $scope.timetrack.id

  $scope.getTimetracks(projectId, taskId)
  $scope.initTimetrack()

  $scope.save = (form)->
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
    i = $scope.timetracks.indexOf(timetrack)
    $scope.timetracks.splice(i, 1)
    
    timetrack.delete().then ->
      console.log 'Timetrack successfuly deleted'
    , ->
      console.log 'Could not delete timetrack'