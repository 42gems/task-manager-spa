app.controller 'ProjectsCtrl', ($scope, $q, Project, $state) ->

  Project.query({}).then (results) ->
    $scope.projects = results
  , (error) ->
    console.log 'Unauthorized request'
  
  Project.$get("/api/projects/members").then (results) ->
    $scope.members = results
  , (error) ->
    console.log 'Unauthorized request'

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

  $scope.deleteProject = (id) ->
    Project.$delete('/api/projects/' + id).then (response) ->
      $state.go('projects', {}, { reload: true })
      console.log 'Project successfuly deleted'
    , (error) ->
      console.log 'Could not remove project'

  $scope.removeMember = (project_id, member_id) ->
    Project.$delete("/api/projects/#{project_id}/remove_member/#{member_id}").then (response) ->
      $state.go('members', {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'
