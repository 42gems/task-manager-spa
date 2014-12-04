app.controller 'TimelineCtrl', ($scope, Timeline, $stateParams) ->

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

    opts =
      from: from

    Timeline.query(opts, {id: $stateParams.projectId}).then (data) ->
      $scope.parseData(data)
