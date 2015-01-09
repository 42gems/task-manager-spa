app.factory 'CurrentProject', ($rootScope) ->
  currentProject = {}
  service =
    get: ->
      currentProject

    set: (val) ->
      currentProject = val
      $rootScope.$broadcast('currentProject:updated', val)

  service
