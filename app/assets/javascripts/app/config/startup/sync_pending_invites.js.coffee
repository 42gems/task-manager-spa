app.run ($rootScope, AuthenticationService, $state, Invite) ->
  $rootScope.$on "$stateChangeSuccess", () ->
    if !AuthenticationService.isLoggedIn.get()
      $rootScope.pendingInvitesCount = 0
    else
      Invite.pendingProjectsCount().then (count) ->
        $rootScope.pendingInvitesCount = count
      , (error) ->
        console.log 'Could not fetch invites'