app.controller 'ProjectsCtrl', ($scope, $q, Project, $state) ->
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
      console.log 'Project successfuly deleted'
    , (error) ->
      console.log 'Could not remove project'
      console.log error

  $scope.saveProject = ->
    Project.$post('/api/projects', 
      title: $scope.project.title
      description: $scope.project.description
      owner_id: $scope.project.ownerId
    ).then (response) ->
      $state.go('projects', {}, { reload: true })
      console.log 'Project successfuly created'
    , (error) ->
      console.log 'Could not create a project'
      console.log error