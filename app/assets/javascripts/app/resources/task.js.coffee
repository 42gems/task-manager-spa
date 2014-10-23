app.factory 'Task', (railsResourceFactory, RailsResource, $famous) ->
  class TaskResource extends RailsResource
    @configure
      url: '/api/projects/{{projectId}}/tasks/{{id}}'
      name: 'task'
