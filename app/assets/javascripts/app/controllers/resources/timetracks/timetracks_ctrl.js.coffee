app.controller 'TimetracksCtrl', ($scope, $q, Timetrack, UserService, $modal) ->
  
  UserService.fetchCurrentUser().success (data) ->
    $scope.currentUser = data

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
