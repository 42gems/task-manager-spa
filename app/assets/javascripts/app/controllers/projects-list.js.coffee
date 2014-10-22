app.controller 'ProjectsListCtrl', ($scope, $q, Project) ->
  Project.query({}).then (results) ->
    $scope.projects = results
  , (error) ->
    console.log 'Unauthorized request'

  $scope.deleteProject = (id) ->
    Project.$delete('/api/projects/' + id).then (response) ->
      for project in $scope.projects
        if project.id == id
          $scope.projects.pop(project)
          break
      console.log 'Project removed'
    , (error) ->
      console.log 'Could not remove project'
