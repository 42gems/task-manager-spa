app.factory 'Task', (railsResourceFactory, RailsResource, railsSerializer) ->
  class TaskResource extends RailsResource
    @configure
      url: '/api/projects/{{projectId}}/tasks/{{id}}'
      name: 'task'
      updateMethod: 'patch'
      serializer: railsSerializer ->
        this.exclude('assignee')
        this.customSerializedAttributes =
          assigneeId: (data)->
            if data.assignee then data.assignee.id else null