app.factory 'Project', (railsResourceFactory) ->
  railsResourceFactory
    url: '/api/projects'
    name: 'project'
    updateMethod: 'patch'