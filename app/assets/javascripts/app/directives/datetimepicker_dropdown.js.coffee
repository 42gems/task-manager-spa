app.directive 'datetimepickerDropdown', () ->
  restrict: 'E'
  templateUrl: 'datetimepicker_dropdown.html'
  scope:
    timeModel: "="
    config: "@"
    dateFormatting: "@"
    addon: "@"
