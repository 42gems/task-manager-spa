app.directive 'membersTile', ->
  restrict: 'E'
  templateUrl: 'directives/members_tile.html'
  controller: 'MembersTileCtrl'
  scope:
    members: '='
