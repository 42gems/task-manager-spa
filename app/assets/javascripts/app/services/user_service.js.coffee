app.factory 'UserService', ($http, $rootScope, User) ->
  service =
    getCurrentUser: ->
      $rootScope.currentUser

    setCurrentUser: (val) ->
      $rootScope.currentUser = val
      $rootScope.$broadcast('currentUser:updated', val)

    fetchCurrentUser: ->
      User.current()

    logIn: (email, password) ->
      $http.post '/api/users/sign_in',
        user:
          email: email
          password: password

    logOut: ->
      $http.delete "/api/users/sign_out"

  service
