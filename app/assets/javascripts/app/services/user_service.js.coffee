app.factory 'UserService', ($http, $rootScope) ->
  currentUser = {}
  service =
    getCurrentUser: ->
      currentUser

    setCurrentUser: (val) ->
      val.fullName = "#{val.firstName} #{val.lastName}"
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
