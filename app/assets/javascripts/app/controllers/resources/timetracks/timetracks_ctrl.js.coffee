app.controller 'TimetracksCtrl', ($scope, $modal, Timetrack, UserService) ->
  $scope.currentUser = UserService.getCurrentUser() if UserService.getCurrentUser()

  $scope.$on 'currentUser:updated', (event, data) ->
    $scope.currentUser = data

  $scope.openModal = (projectId, task) ->
    modalInstance = $modal.open
      templateUrl: "timetracks/timetracks_modal.html"
      controller: "TimetracksModalInstanceCtrl"
      resolve:
        projectId: ->
          projectId
        task: ->
          task
        currentUser: ->
          $scope.currentUser

    modalInstance.result.then (timetrack) ->
      console.log 'Timetrack successfuly created'
    , ->
      console.log "Modal dismissed"
