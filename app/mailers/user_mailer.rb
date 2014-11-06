class UserMailer < ActionMailer::Base
  default from: "task-manager-spa@42gems.com"

  def send_invite(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: 'Invitation to the project').deliver
  end
end
