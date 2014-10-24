app.controller 'ProjectsCtrl', ($scope, $q, Project, $stateParams, $state) ->
  
  Project.get({ id: $stateParams.id }).then (results) ->
    $scope.project = results
  , (error) ->
    console.log 'Could not fetch project'

  $scope.saveProject = ->
    $scope.project.save().then (response) ->
      console.log 'Project successfuly updated'
      $state.go('project', {}, { reload: true })
    , (error) ->
      console.log 'Could not update the project'
      console.log error

  $scope.delete = ->
    $scope.project.delete().then (respone) ->
      console.log 'Project successfuly deleted'
      $state.go 'projects'
    , (error) ->
      console.log 'Could not delete the project'
      console.log error