app.factory 'ProjectsService', ($rootScope) ->
  projects = undefined
  service =
    get: ->
      projects

    set: (val) ->
      unless angular.equals(projects, val)
        projects = val
        $rootScope.$broadcast('projects:updated', val)

  service
