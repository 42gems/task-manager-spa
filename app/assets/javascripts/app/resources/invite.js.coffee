app.factory 'Invite', (railsResourceFactory, RailsResource) ->
  class InviteResource extends RailsResource
    @configure
      url: '/api/invites/{{inviteId}}'
      name: 'invite'
      updateMethod: 'patch'
