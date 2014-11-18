app.directive 'tasksColumn', () ->
  restrict: 'E'
  templateUrl: 'tasks/tasks_column.html'
  controller: "TasksCtrl"
  scope:
    tasks: "="
    state: "@"
    stateTitle: "@"
    dropSuccess: "&"
  replace: true
