app.directive 'projectsTile', ->
  restrict: 'E'
  templateUrl: 'directives/projects_tile.html'
  controller: 'ProjectsTileCtrl'
  scope:
    projects: '='
