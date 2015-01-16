app.directive 'file', () ->
  restrict: 'E'
  template: [
    '<div>',
      '<span class="btn btn-success">Choose picture</span>',
      '<input type="file" style="display:none"/>',
      '<div style="display:none; margin-top: 15px;">',
        '<img style="max-width: 200px; max-height: 200px; display:block"/>',
      '</div>'
    '</div>'
  ].join('')
  replace: true
  scope:
    user: '='
  link: (scope, element, attributes, parentCtrl) ->
    scope.showImage = false
    $('span', element).click ->
      $('input[type=file]', element).click()
    element.change (event) ->
      reader = new FileReader()
      reader.onload = (event) ->
        scope.user.imageData = event.target.result
        $('img', element).attr('src', event.target.result)
        .parent().css('display', 'block')
      reader.readAsDataURL event.target.files[0]