app.factory 'ProjectsService', ($rootScope) ->
  projects = undefined
  service =
    get: ->
      projects

    set: (projects) ->
      unless angular.equals(projects, projects)
        projects = projects
        $rootScope.$broadcast('projects:updated', projects)

    add: (project) ->
      projects.push(project)
      $rootScope.$broadcast('projects:updated', projects)

  service
