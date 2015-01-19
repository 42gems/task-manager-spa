app.factory 'CurrentProject', ($rootScope) ->
  currentProject = {}
  service =
    get: ->
      currentProject

    set: (val) ->
      unless angular.equals(currentProject, val)
        currentProject = val
        $rootScope.$broadcast('currentProject:updated', val)
    updateTimetracks: ->
      $rootScope.$broadcast('currentProject:updateTimetracks')

  service
