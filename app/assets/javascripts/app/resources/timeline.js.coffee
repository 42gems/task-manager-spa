app.factory 'Timeline', (railsResourceFactory, RailsResource) ->
  class TimelineResource extends RailsResource
    @configure
      url: '/api/projects/{{id}}/timeline_matrix'
      name: 'timeline'
      updateMethod: 'patch'
