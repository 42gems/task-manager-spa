app.controller 'TimelineCtrl', ($scope, Project, $stateParams) ->

  Project.timelineMatrix($stateParams.projectId).then (data) ->
    $scope.matrix = data
