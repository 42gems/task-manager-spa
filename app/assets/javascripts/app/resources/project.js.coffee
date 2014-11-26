app.factory 'Project', (railsResourceFactory) ->
  Project = railsResourceFactory
    url: '/api/projects'
    name: 'project'
    updateMethod: 'patch'
  
  Project.members = (id) ->
    @$get(@$url() + "/#{id}/members")

  Project.usersForInvite = (id) ->
    @$get(@$url() + "/#{id}/users_for_invite")
  
  Project.timelineMatrix = (id) ->
    @$get(@$url() + "/#{id}/timeline_matrix")

  Project.prototype.removeMember = (memberId) ->
    @$delete(@$url() + "/remove_member/#{memberId}")
  
  Project.prototype.addMember = (memberId) ->
    Project.$patch(@$url() + "/add_member/#{memberId}")

  Project
