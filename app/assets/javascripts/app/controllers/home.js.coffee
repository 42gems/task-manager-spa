app.controller 'HomeCtrl', ($scope, $q, Project) ->
  $scope.$on '$viewContentLoaded', ->
    Project.query({}).then (results) ->
      $scope.projects = results
    , (error) ->
      console.log 'Unauthorized request'