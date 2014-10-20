app.factory 'UserService', ($http) ->
  logIn: (email, password) ->
    $http.post '/api/users/sign_in',
      user:
        email: email
        password: password
  logOut: ->
    $http.delete "/api/users/sign_out"