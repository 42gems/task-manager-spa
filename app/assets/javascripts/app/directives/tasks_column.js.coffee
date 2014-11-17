app.directive 'tasksColumn', () ->
  {
    restrict: 'E'
    templateUrl: 'tasks/tasks_column.html'
    scope: {
      tasks: "="
      state: "@"
      dropSuccess: "&"
    }
  }
