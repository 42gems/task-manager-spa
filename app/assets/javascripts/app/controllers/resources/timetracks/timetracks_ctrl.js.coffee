app.controller 'TimetracksCtrl', ($scope, $q, Timetrack, UserService, $modal) ->
  $scope.currentUser = UserService.getCurrentUser()

  $scope.openModal = (projectId, taskId) ->
    modalInstance = $modal.open
      templateUrl: "timetracks/timetracks_modal.html"
      controller: "TimetracksModalInstanceCtrl"
      resolve:
        projectId: ->
          projectId
        taskId: ->
          taskId
        currentUser: ->
          $scope.currentUser

    modalInstance.result.then (timetrack) ->
      console.log 'Timetrack successfuly created'
    , ->
      console.log "Modal dismissed"
