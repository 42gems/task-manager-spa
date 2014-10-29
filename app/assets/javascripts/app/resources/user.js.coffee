app.factory 'User', (railsResourceFactory) ->
  railsResourceFactory
    url: '/api/users'
    name: 'user'
    updateMethod: 'patch'