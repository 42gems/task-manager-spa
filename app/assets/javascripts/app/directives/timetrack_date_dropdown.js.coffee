app.directive 'timetrackDateDropdown', () ->
  restrict: 'E'
  templateUrl: 'timetracks/date_dropdown.html'
  replace: true
  scope:
    timetrack: "="
    dpid: "@"
