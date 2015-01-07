app.factory 'ModalService', ($modal) ->
  service =
    confirm: (caption) ->
      $modal.open(
        templateUrl: 'modal/confirm.html'
        controller: 'ModalConfirmCtrl'
        size: 'sm'
        resolve:
          caption: -> caption
      ).result

  service