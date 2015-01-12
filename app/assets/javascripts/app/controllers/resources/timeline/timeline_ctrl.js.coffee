app.controller 'TimelineCtrl', ($scope, $modal, Timeline) ->

  $scope.parseData = (timelineMatrix) ->
    matrix = timelineMatrix
    $scope.dates  = matrix.shift()
    $scope.tracks = matrix

  $scope.updateContext = ->
    Timeline.get($scope.currentProject.id).then (timelineMatrix) ->
      $scope.parseData(timelineMatrix)

  $scope.getLastWeekTimeline = ->
    Timeline.get($scope.currentProject.id).then (timelineMatrix) ->
      $scope.parseData(timelineMatrix)

  $scope.getLastMonthTimeline = ->
    from = new Date()
    from.setMonth(from.getMonth() - 1)

    Timeline.query({ from: from }, { id: $scope.currentProject.id }).then (timelineMatrix) ->
      $scope.parseData(timelineMatrix)

  $scope.getCustomTimeline = (range) ->
    Timeline.query( range, { id: $scope.currentProject.id }).then (timelineMatrix) ->
      $scope.parseData(timelineMatrix)

  $scope.openModal = ->
    modalInstance = $modal.open
      templateUrl: "timeline/datetime_range_modal.html"
      controller: "DatetimeRangeModalInstanceCtrl"

    modalInstance.result.then (chosen_range) ->
      $scope.getCustomTimeline(chosen_range)
    , ->
      console.log "Modal dismissed"

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()
