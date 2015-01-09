app.run ($rootScope, AuthenticationService, $state, Invite, User, UserService) ->
  $rootScope.$state = $state
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    if !toState.skipLogin && !AuthenticationService.isLoggedIn
      event.preventDefault()
      $state.go('sign_in')
    else
      User.current({}).then (data) ->
        UserService.setCurrentUser(data)
      , ->
        console.log 'Could not fetch current user'

  $rootScope.$on "$stateChangeSuccess", () ->
    if !AuthenticationService.isLoggedIn
      $rootScope.pendingInvites = 0
    else
      Invite.pendingProjects().then (count) ->
        $rootScope.pendingInvites = count
      , (error) ->
        console.log 'Could not fetch invites'

