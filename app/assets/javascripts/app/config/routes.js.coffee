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
      controller: 'ProjectsCtrl'
    .state 'projects.new',
      url: '/new'
      views:
        'project':
          templateUrl: 'projects/form.html'
          controller: 'ProjectsCtrl'
    .state 'projects.tasks',
      url: '/:projectId/tasks-drag'
      views:
        'tasks':
          templateUrl: 'tasks/index.html'
          controller: 'TasksCtrl'
    .state 'project',
      url: '/projects/:projectId'
      templateUrl: 'projects/show.html'
      controller: 'ProjectCtrl'
    .state 'project.edit',
      url: '/edit'
      templateUrl: 'projects/form.html'
      controller: 'ProjectCtrl'
    .state 'project.tasks',
      url: '/tasks'
      templateUrl: 'tasks/tasks_list.html'
      controller: 'TasksCtrl'
    .state 'project.tasks.edit',
      url: '/:taskId/edit'
      templateUrl: 'tasks/edit.html'
      controller: 'TaskCtrl'
    .state 'sign_up',
      url: '/sign_up'
      templateUrl: 'sign_up.html'
      controller: 'SignUpCtrl'
      skipLogin: true
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
  $rootScope.$state = $state
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    if !toState.skipLogin && !AuthenticationService.isLoggedIn
      event.preventDefault()
      $state.go('sign_in')
