app.controller 'InvitesCtrl', ($scope, $q, Invite, $state) ->

  Invite.query({}).then (invites) ->
    $scope.invites = invites
  , (err) ->
    console.log 'Could not fetch invites'

  $scope.accept = (invite) ->
    invite.accepted = true
    Invite.$patch("/api/invites/#{invite.id}", invite).then (response) ->
      console.log 'Invite was successfully accepted'
      $state.go($state.current, {}, { reload: true })
    , (err) ->
      console.log 'Invite was not accepted due to some error'
  
  $scope.decline = (invite) ->
    Invite.$delete("/api/invites/#{invite.id}").then (response) ->
      console.log 'Invite declined'
      $state.go($state.current, {}, { reload: true })
    , (err) ->
      console.log 'Invite was not declined due to some error'
