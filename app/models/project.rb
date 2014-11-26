class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :tasks,   dependent: :destroy
  has_many :members,    through: :invites, source: :user
  has_many :timetracks, through: :tasks

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  scope :is_public, -> { where private: false }

  def select_users_for_invites
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    User.where.not(id: user_ids)
  end

  # [ ['', day1, day2, day3], [email, '', 9, ''], ... ]
  def timeline_matrix
    date_formatting = '%d/%m/%y'
    matrix = []
    
    if timetracks.any?
      matrix << timetracks.map { |t| t.start_date.strftime(date_formatting) }.uniq.unshift('')

      timetracks.includes(:user).each do |track|
        row = [''] * matrix[0].length
        date = track.start_date.strftime(date_formatting)
        i = matrix[0].index(date)

        row[0] = track.user.email
        row[i] = track.amount
        matrix << row
      end
    end

    matrix
  end
end
