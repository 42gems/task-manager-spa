# require 'test_helper'

# class UserSignOut < ActionDispatch::IntegrationTest
#   setup { @user = User.create email: 'user@example.com', password: 'password' }

#   test 'deletes current token' do
#     delete "/api/users/#{@user.id}/sign_out"
#     assert_equal 204, response.status
#   end
# end