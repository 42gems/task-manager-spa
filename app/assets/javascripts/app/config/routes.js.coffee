taskManagerSPA.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/home')
  $stateProvider
    .state 'home',
      url: '/home'
      templateUrl: 'home.html'
    .state 'famous-flipper',
      url: '/famous-flipper'
      templateUrl: 'famous-flipper.html'
      controller: 'FamousFlipperCtrl'
