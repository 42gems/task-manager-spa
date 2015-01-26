app.factory 'Invite', (railsResourceFactory, RailsResource) ->
  class InviteResource extends RailsResource
    @configure
      url: '/api/invites/{{inviteId}}'
      name: 'invite'
      updateMethod: 'patch'

    @pendingProjectsCount = ->
      @$get('/api/invites/pending_invites_count')
