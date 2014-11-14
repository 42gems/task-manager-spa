app.factory 'Project', (railsResourceFactory) ->
  Project = railsResourceFactory
    url: '/api/projects'
    name: 'project'
    updateMethod: 'patch'
  
  Project.members = (id) ->
    @$get(@$url() + "/#{id}/members")
  
  Project.prototype.removeMember = (memberId) ->
    @$delete(@$url() + "/remove_member/#{memberId}")
  
  Project.usersForInvite = (id) ->
    @$get(@$url() + "/#{id}/users_for_invite")
  
  Project.prototype.addMember = (memberId) ->
    Project.$get(@$url() + "/add_member/#{memberId}")

  Project
