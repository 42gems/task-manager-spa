app.controller 'ProjectsCtrl', ($scope, $q, Project, $stateParams) ->
  console.log $stateParams
  Project.get({ id: $stateParams.id }).then (results) ->
    $scope.project = results
    console.log results
  , (error) ->
    console.log 'Could not fetch project'
