app.controller 'ProjectsCtrl', ($scope, $q, Project, $stateParams) ->
  Project.query({}).then (results) ->
    $scope.projects = results
  , (error) ->
    console.log 'Unauthorized request'
  
  if $stateParams.id
    Project.get($stateParams.id).then (results) ->
      $scope.current_project = results
    , (error) ->
      console.log 'Could not retrieve project'
