app.controller 'ProjectsListCtrl', ($scope, $q, Project) ->
  Project.query({}).then (results) ->
    $scope.projects = results
  , (error) ->
    console.log 'Unauthorized request'
