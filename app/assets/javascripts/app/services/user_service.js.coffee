app.factory 'UserService', ($http, $rootScope) ->
  currentUser = {}
  service =
    getCurrentUser: ->
      currentUser

    setCurrentUser: (val) ->
      currentUser = val
      $rootScope.$broadcast('currentUser:updated', val)

    signup: (user) ->
      user.create()

    logIn: (email, password) ->
      $http.post '/api/users/sign_in',
        user:
          email: email
          password: password

    logOut: ->
      $http.delete "/api/users/sign_out"

  service
