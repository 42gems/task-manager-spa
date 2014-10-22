app.controller 'ProjectsCtrl', ($scope, $q, Project, $stateParams) ->
  
  Project.get({ id: $stateParams.id }).then (results) ->
    $scope.project = results
  , (error) ->
    console.log 'Could not fetch project'
