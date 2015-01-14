app.controller 'TimelineCtrl', ($scope, $modal, Timeline, CurrentProject) ->
  $scope.currentProject = CurrentProject.get() if CurrentProject.get()
  $scope.range =
    from: new Date()
    to:   new Date()

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

  $scope.getCustomTimeline = ->
    Timeline.query( $scope.range, { id: $scope.currentProject.id }).then (timelineMatrix) ->
      $scope.parseData(timelineMatrix)

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data
    $scope.updateContext()

  $scope.$watch 'range', ->
    $scope.getCustomTimeline() if $scope.currentProject
  , true
