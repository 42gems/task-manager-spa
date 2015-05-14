3.times do |i|
  User.create!(first_name: "user", last_name: "#{i}", email: "user#{i}@example.com", password: "password") unless User.where(email: "user#{i}@example.com").exists?
end

User.first.projects.create title: 'Project #1'
p = Project.first

User.all[1..-1].each do |u|
  p.invites.create! user_id: u.id
end

7.times do |n|
  p.tasks.create! title: "task ##{n}", state: Task.aasm.states.map{|state| state.name}[rand(3)]
end

p.tasks.first.comments.create! user_id: p.owner.id, body: 'yo meh'
