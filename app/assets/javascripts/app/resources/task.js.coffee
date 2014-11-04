app.factory 'Task', (railsResourceFactory, RailsResource) ->
  class TaskResource extends RailsResource
    @configure
      url: '/api/projects/{{projectId}}/tasks/{{id}}'
      name: 'task'
      updateMethod: 'patch'
