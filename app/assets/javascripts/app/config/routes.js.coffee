app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/home')
  $stateProvider
    .state 'home',
      url: '/home'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
    .state 'famous-flipper',
      url: '/famous-flipper'
      templateUrl: 'famous-flipper.html'
      controller: 'FamousFlipperCtrl'
    .state 'sign_in',
      url: '/sign_in'
      templateUrl: 'sign_in.html'
      controller: 'SignInCtrl'
      skipLogin: true

app.run ($rootScope, $location, AuthenticationService, $state) ->
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    if !toState.skipLogin && !AuthenticationService.isLoggedIn
      event.preventDefault()
      $state.go('sign_in')
