app
  .controller 'FamousFlipperCtrl', ($scope, $famous) ->
    EventHandler = $famous['famous/core/EventHandler']

    $scope.evt = new EventHandler()

    $scope.flip = ->
      $famous.find('#flipper')[0].flip()