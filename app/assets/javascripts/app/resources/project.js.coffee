app.factory 'Project', (railsResourceFactory, RailsResource) ->
  class ProjectResource extends RailsResource
    @configure
      url: '/api/projects'
      name: 'project'
      updateMethod: 'patch'

    @members = (id) ->
      @$get(@$url() + "/#{id}/members")

    @membersWithUserRights = (id) ->
      @$get(@$url() + "/#{id}/members_with_user_rights")

    @usersForInvite = (id) ->
      @$get(@$url() + "/#{id}/users_for_invite")

    @timelineMatrix = (id) ->
      @$get(@$url() + "/#{id}/timeline_matrix")

    @prototype.removeMember = (memberId) ->
      @$delete(@$url() + "/remove_member/#{memberId}")

    @prototype.addMember = (memberId) ->
      ProjectResource.$patch(@$url() + "/add_member/#{memberId}")
