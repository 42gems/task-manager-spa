app.config ($httpProvider) ->
  $httpProvider.interceptors.push('TokenInterceptor')