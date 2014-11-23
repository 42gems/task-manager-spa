app.factory 'Timetrack', (railsResourceFactory, RailsResource) ->
  class TimetrackResource extends RailsResource
    @configure
      url: '/api/projects/{{projectId}}/tasks/{{taskId}}/timetracks/{{id}}'
      name: 'timetrack'
      updateMethod: 'patch'
