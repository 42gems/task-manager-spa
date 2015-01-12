app.factory 'CurrentProject', ($rootScope) ->
  currentProject = {}
  service =
    get: ->
      currentProject

    set: (val) ->
      if !angular.equals(currentProject, val)
        currentProject = val
        $rootScope.$broadcast('currentProject:updated', val)

  service
