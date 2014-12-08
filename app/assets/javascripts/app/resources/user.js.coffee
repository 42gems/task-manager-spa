app.factory 'User', (railsResourceFactory, RailsResource) ->
  class UserResource extends RailsResource
    @configure
      url: '/api/users'
      name: 'user'
      updateMethod: 'patch'
