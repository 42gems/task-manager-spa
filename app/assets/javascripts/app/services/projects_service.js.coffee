app.factory 'ProjectsService', ($rootScope) ->
  projects = undefined
  service =
    get: ->
      projects

    set: (val) ->
      unless angular.equals(projects, val)
        projects = val
        $rootScope.$broadcast('projects:updated', val)

    add: (project) ->
      projects.push(project)
      $rootScope.$broadcast('projects:updated', projects)

  service
