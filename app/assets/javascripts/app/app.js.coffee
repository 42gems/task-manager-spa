angular.module('taskManagerSPA', ['famous.angular'])
  .controller 'IndexCtrl', ($scope, $famous) ->
    EventHandler = $famous['famous/core/EventHandler']

    $scope.evt = new EventHandler()

    $scope.flip = ->
      $famous.find('#flipper')[0].flip()