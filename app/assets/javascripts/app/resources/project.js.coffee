app.factory 'Project', (railsResourceFactory) ->
  Project = railsResourceFactory
    url: '/api/projects'
    name: 'project'
    updateMethod: 'patch'
  
  Project.members = (id) ->
    @$get(@$url() + "/#{id}/members")
  
  Project.prototype.removeMember = (memberId) ->
    @$delete(@$url() + "/remove_member/#{memberId}")
  
  Project.users_for_invite = (id) ->
    @$get(@$url() + "/#{id}/users_for_invite")
  
  Project.prototype.sendInvite = (memberId) ->
    Project.$get(@$url() + "/send_invite/#{memberId}")

  Project
