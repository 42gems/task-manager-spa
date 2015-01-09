app.controller 'MembersCtrl', ($scope, $state, Project, CurrentProject) ->

  $scope.$on 'currentProject:updated', (event, data) ->
    $scope.currentProject = data

    Project.members($scope.currentProject.id).then (results) ->
      $scope.members = results
    , (error) ->
      console.log 'Could not fetch members of a project'

    Project.userRights($scope.currentProject.id).then (results) ->
      $scope.isManagable = results is 'owner'
    , (error) ->
      console.log 'Could not fetch members of a project'

  $scope.removeMember = (member_id) ->
    $scope.currentProject.removeMember(member_id).then (response) ->
      i = $scope.members.indexOf(member) for member in $scope.members when member_id == member.id
      $scope.members.splice(i, 1)
      console.log 'Member successfuly removed from the project'
    , (error) ->
      console.log 'Could not remove member'
