app.directive 'humanizedAmount', ($filter) ->
  require: 'ngModel'
  link: (scope, element, attrs, ngModelController) ->
    ngModelController.$parsers.push (data) ->
      $filter('timeToSeconds')(data)

    ngModelController.$formatters.push (data) ->
      $filter('secondsToTime')(data)
