app.controller 'TimetracksCtrl', ($scope, $q, Timetrack, $modal) ->

  $scope.openModal = (projectId, taskId) ->
    modalInstance = $modal.open
      templateUrl: "timetracks_modal.html"
      controller: "TimetracksModalInstanceCtrl"
      resolve:
        projectId: ->
          projectId
        taskId: ->
          taskId

    modalInstance.result.then (timetrack) ->
      console.log 'Timetrack successfuly created'
    , ->
      console.log "Modal dismissed"
