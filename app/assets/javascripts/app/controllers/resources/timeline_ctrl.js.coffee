app.controller 'TimelineCtrl', ($scope, Project, $stateParams) ->

  Project.timelineMatrix($stateParams.projectId).then (data) ->
    matrix = data
    $scope.dates  = matrix.shift()
    $scope.tracks = matrix
