app.controller 'ProjectCtrl', ($scope, $q, Project, $stateParams, $state) ->

  Project.get({ id: $stateParams.projectId }).then (results) ->
    $scope.project = results
  , (error) ->
    console.log 'Could not fetch project'

  Project.get("#{$stateParams.projectId}/members").then (results) ->
    $scope.members = results
  , (error) ->
    console.log 'Could not fetch members of a project'

  Project.get("#{$stateParams.projectId}/users_for_invite").then (results) ->
    $scope.usersForInvite = results  
    $scope.selected = $scope.usersForInvite[0]
  , (error) ->
    console.log 'Could not fetch users for invite'

  $scope.saveProject = ->
    $scope.project.save().then (response) ->
      console.log 'Project successfuly updated'
      $state.go('project', {}, { reload: true })
    , (error) ->
      console.log 'Could not update the project'

  $scope.delete = ->
    $scope.project.delete().then (respone) ->
      console.log 'Project successfuly deleted'
      $state.go 'projects'
    , (error) ->
      console.log 'Could not delete the project'

  $scope.removeMember = (member_id) ->
    project_id = $scope.project.id
    Project.$delete("/api/projects/#{project_id}/remove_member/#{member_id}").then (response) ->
      $state.go($state.current, {}, { reload: true })
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'

  $scope.sendInvite = (member_id) ->
    project_id = $scope.project.id
    Project.$post("/api/projects/#{project_id}/send_invite/#{member_id}").then (response) ->
      console.log 'Invitation has been sent'
    , (error) ->
      console.log 'Could not send an invitation'
