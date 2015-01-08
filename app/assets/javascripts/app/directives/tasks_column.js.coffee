app.directive 'tasksColumn', () ->
  restrict: 'E'
  templateUrl: 'directives/tasks_column.html'
  controller: "TasksCtrl"
  scope:
    state: "@"
    stateTitle: "@"
  replace: true
