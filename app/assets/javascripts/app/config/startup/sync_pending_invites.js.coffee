app.run ($rootScope, AuthenticationService, $state, Invite) ->
  $rootScope.$on "$stateChangeSuccess", () ->
    if !AuthenticationService.isLoggedIn
      $rootScope.pendingInvites = 0
    else
      Invite.pendingProjects().then (count) ->
        $rootScope.pendingInvites = count
      , (error) ->
        console.log 'Could not fetch invites'