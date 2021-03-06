app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/board')
  $stateProvider
    .state 'profile',
      url: '/profile'
      templateUrl: 'profile.html'
      controller: 'ProfileCtrl'
    .state 'board',
      url: '/board'
      templateUrl: 'board.html'
      controller: 'BoardCtrl'
    .state 'invites',
      url: '/invites'
      templateUrl: 'invites.html'
      controller: 'InvitesCtrl'
    .state 'members',
      url: '/members'
      templateUrl: 'members.html'
      controller: 'MembersCtrl'
    .state 'timeline',
      url: '/timeline'
      templateUrl: 'timeline/index.html'
      controller: 'TimelineCtrl'
    .state 'projects',
      url: '/projects'
      templateUrl: 'projects/index.html'
      controller: 'ProjectsCtrl'
    .state 'projects.new',
      url: '/new'
      views:
        'project':
          templateUrl: 'projects/form.html'
          controller: 'ProjectsCtrl'
    .state 'sign_up',
      url: '/sign_up'
      templateUrl: 'authentication/sign_up.html'
      controller: 'SignUpCtrl'
      skipLogin: true
    .state 'sign_in',
      url: '/sign_in'
      templateUrl: 'authentication/sign_in.html'
      controller: 'SignInCtrl'
      skipLogin: true
      onEnter: ($state, AuthenticationService, $timeout) ->
        $timeout ->
          if AuthenticationService.isLoggedIn.get()
            $state.go('board')
