app.factory 'User', (railsResourceFactory, RailsResource) ->
  class UserResource extends RailsResource
    @configure
      url: '/api/users'
      name: 'user'
      updateMethod: 'patch'

    @projects = (id) ->
      @$get(@$url() + "/#{id}/projects")

    @invitedMembers = (id) ->
      @$get(@$url() + "/#{id}/invited_members")

    @current = ->
      @$get(@$url() + "/current")