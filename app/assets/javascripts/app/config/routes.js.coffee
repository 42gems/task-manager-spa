app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/board')
  $stateProvider
    .state 'board',
      url: '/board'
      templateUrl: 'board.html'
      controller: 'BoardCtrl'
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
    .state 'invites',
      url: '/invites'
      templateUrl: 'invites.html'
      controller: 'InvitesCtrl'
    .state 'members',
      url: '/members'
      templateUrl: 'members.html'
      controller: 'MembersCtrl'
    .state 'project',
      url: '/projects/:projectId'
      templateUrl: 'projects/show.html'
      controller: 'ProjectCtrl'
    .state 'project.timeline',
      url: '/timeline'
      templateUrl: 'timeline/index.html'
      controller: 'TimelineCtrl'
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
          if AuthenticationService.isLoggedIn
            $state.go('board')
