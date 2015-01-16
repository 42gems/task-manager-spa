app.directive 'datetimepickerDropdown', () ->
  restrict: 'E'
  templateUrl: 'directives/datetimepicker_dropdown.html'
  scope:
    timeModel: "="
    config: "@"
    dateFormatting: "@"
    addon: "@"
    formGroup: "@"