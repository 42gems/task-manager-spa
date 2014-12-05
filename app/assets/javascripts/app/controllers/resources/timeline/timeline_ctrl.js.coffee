app.controller 'TimelineCtrl', ($scope, Timeline, $stateParams, $modal) ->

  $scope.parseData = (data) ->
    matrix = data
    $scope.dates  = matrix.shift()
    $scope.tracks = matrix

  Timeline.get($stateParams.projectId).then (data) ->
    $scope.parseData(data)

  $scope.getLastWeekTimeline = ->
    Timeline.get($stateParams.projectId).then (data) ->
      $scope.parseData(data)

  $scope.getLastMonthTimeline = ->
    from = new Date()
    from.setMonth(from.getMonth() - 1)

    Timeline.query({ from: from }, { id: $stateParams.projectId }).then (data) ->
      $scope.parseData(data)

  $scope.getCustomTimeline = (range) ->
    Timeline.query( range, { id: $stateParams.projectId }).then (data) ->
      $scope.parseData(data)

  $scope.openModal = ->
    modalInstance = $modal.open
      templateUrl: "timeline/datetime_range_modal.html"
      controller: "DatetimeRangeModalInstanceCtrl"

    modalInstance.result.then (data) ->
      $scope.getCustomTimeline(data)
    , ->
      console.log "Modal dismissed"
