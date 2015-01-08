app.controller 'TimelineCtrl', ($scope, $modal, Timeline) ->

  $scope.parseData = (data) ->
    matrix = data
    $scope.dates  = matrix.shift()
    $scope.tracks = matrix

  $scope.updateContext = ->
    Timeline.get($scope.currentProject.id).then (data) ->
      $scope.parseData(data)

  $scope.getLastWeekTimeline = ->
    Timeline.get($scope.currentProject.id).then (data) ->
      $scope.parseData(data)

  $scope.getLastMonthTimeline = ->
    from = new Date()
    from.setMonth(from.getMonth() - 1)

    Timeline.query({ from: from }, { id: $scope.currentProject.id }).then (data) ->
      $scope.parseData(data)

  $scope.getCustomTimeline = (range) ->
    Timeline.query( range, { id: $scope.currentProject.id }).then (data) ->
      $scope.parseData(data)

  $scope.openModal = ->
    modalInstance = $modal.open
      templateUrl: "timeline/datetime_range_modal.html"
      controller: "DatetimeRangeModalInstanceCtrl"

    modalInstance.result.then (data) ->
      $scope.getCustomTimeline(data)
    , ->
      console.log "Modal dismissed"

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()
