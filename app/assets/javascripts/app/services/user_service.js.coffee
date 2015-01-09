app.factory 'UserService', ($http, $rootScope, User) ->
  currentUser = {}
  service =
    getCurrentUser: ->
      currentUser

    setCurrentUser: (val) ->
      currentUser = val
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
