app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/projects')
  $stateProvider
    .state 'home',
      url: '/home'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
    .state 'famous-flipper',
      url: '/famous-flipper'
      templateUrl: 'famous-flipper.html'
      controller: 'FamousFlipperCtrl'
    .state 'projects',
      url: '/projects'
      templateUrl: 'projects/index.html'
      controller: 'ProjectsListCtrl'
    .state 'projects.new',
      url: '/new'
      views:
        'project':
          templateUrl: 'projects/edit.html'
          controller: 'ProjectsListCtrl'
    .state 'projects.tasks',
      url: "/:projectId/tasks"
      views:
        'tasks':
          templateUrl: "tasks/index.html"
          controller: "TasksCtrl"
    .state 'project',
      url: '/projects/:id'
      templateUrl: 'projects/show.html'
      controller: 'ProjectsCtrl'
    .state 'project.edit',
      url: '/edit'
      templateUrl: 'projects/edit.html'
      controller: 'ProjectsCtrl'
    .state 'sign_in',
      url: '/sign_in'
      templateUrl: 'sign_in.html'
      controller: 'SignInCtrl'
      skipLogin: true
      onEnter: ($state, AuthenticationService, $timeout) ->
        $timeout ->
          if AuthenticationService.isLoggedIn
            $state.go('home')

app.run ($rootScope, $location, AuthenticationService, $state) ->
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    if !toState.skipLogin && !AuthenticationService.isLoggedIn
      event.preventDefault()
      $state.go('sign_in')
