app.factory 'UserService', ($http) ->
  logIn: (email, password) ->
    $http.post '/api/users/sign_in',
      user:
        email: email
        password: password
  logOut: ->
    console.log 'Please, implement logout'