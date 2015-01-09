app.directive 'tasksColumn', () ->
  restrict: 'E'
  templateUrl: 'directives/tasks_column.html'
  controller: 'TasksColumnCtrl'
  scope:
    tasks: '='
    state: '@'
    stateTitle: '@'
    isManagable: '='
  replace: true
