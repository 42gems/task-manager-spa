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

  def timeline_matrix
    timetracks.any? ? build_matrix : []
  end

  private

  # [ ['', day1, day2, day3, ...], [email, '', amount, ''], ... ]
  def build_matrix
    date_formatting = '%d/%m/%y'
    matrix = []
    matrix << timetracks.map { |t| t.start_date.strftime(date_formatting) }.uniq.unshift('')
    members = []
    members << self.members.includes(:timetracks)
    members << self.owner
    
    members.flatten!.each do |member|
      if member.timetracks.any?
        row = [''] * matrix[0].length
        row[0] = member.email

        member.timetracks.each do |track|
          date = track.start_date.strftime(date_formatting)
          i    = matrix[0].index(date)
          
          increase_amount(track.amount, row, i) unless i.nil?
        end
        matrix << row
      end
    end
    matrix
  end

  def increase_amount(amount, row, i)
    if row[i].is_a? Integer
      row[i] += amount 
    else
      row[i] = amount
    end
  end
end
