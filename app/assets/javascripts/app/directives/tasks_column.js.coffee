app.directive 'tasksColumn', () ->
  restrict: 'E'
  templateUrl: 'directives/tasks_column.html'
  controller: "TasksCtrl"
  scope:
    tasks: "="
    state: "@"
    stateTitle: "@"
  replace: true
