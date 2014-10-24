3.times do |i|
  User.create!(email: "user#{i}@example.com", password: "password") unless User.where(email: "user#{i}@example.com").exists?
end

User.first.projects.create title: 'Project #1'
p = Project.first

User.all[1..-1].each do |u|
  p.invites.create! user_id: u.id
end

6.times do |n|
  p.tasks.create! title: "task ##{n}", state: Task::STATES.keys[rand(5)]
end

p.tasks.first.comments.create! user_id: p.owner.id, body: 'yo meh'
