app.controller 'TimelineCtrl', ($scope, $modal, Timeline, CurrentProject) ->
  $scope.range =
    from: new Date()
    to:   new Date()

  $scope.updateContext = ->
    Timeline.get($scope.currentProject.id).then (timetracks) ->
      $scope.dates = [];
      $scope.timetracks = timetracks.map (track) ->
        date = new Date(track.updatedAt).toDateString()
        track.date = date
        $scope.dates.push date if $scope.dates.indexOf(date) == -1
        track


  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()

  if CurrentProject.get()
    $scope.currentProject = CurrentProject.get()
    $scope.updateContext()