# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lorem = 'Id non repudiandae nostrum error sint culpa. Ipsam tempora incidunt aut. Sequi consequatur earum ut. Fuga et in sint illum molestiae iste temporibus. Sit qui accusantium a sed.

Magni rerum quod provident consequatur corrupti. Deleniti et perferendis cupiditate et saepe maxime. Sit consequatur itaque minima earum quibusdam. Ipsa repellat quam ut beatae. Laboriosam minima vero sit adipisci qui laudantium. Dicta ea voluptates quasi.

Et consequuntur qui quisquam facere. Eum porro corrupti accusamus et dolor quia est aut. Labore dolores nostrum autem fugiat ipsam quibusdam.

Voluptatem porro itaque molestiae quis delectus nostrum veniam. Molestiae temporibus id culpa harum sint ullam corrupti. Aut nihil ea non minima officia iste nobis debitis.

Perspiciatis autem et reiciendis asperiores. Et expedita aut qui sit mollitia in iusto. Quia enim non ratione dolorum impedit non consequatur enim.
<b>BOLD PART to test HTML escaping</b>'

puts 'Adding example users...'
# Admin user
User.create!(name:  'Admin User',
             email: 'example@railstutorial.org',
             password:              'password72',
             password_confirmation: 'password72',
             user_type: 2)

# Employer
User.create!(name: 'Some Employer',
             email: 'employer@example.com',
             password: 'asdfasdfasdf',
             password_confirmation: 'asdfasdfasdf',
             user_type: 1)

# Applicant
User.create!(name: 'asdf',
             email: 'asdf@asdf.com',
             password: 'asdfasdfasdf',
             password_confirmation: 'asdfasdfasdf')

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password72"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

puts 'Adding examples skills...'
Skill.create!(title: 'Programming', description: 'Whatever')
Skill.create!(title: 'Writing', description: 'Whatever')
Skill.create!(title: 'Teaching', description: 'Whatever')
Skill.create!(title: 'Wanking', description: 'Whatever')
Skill.create!(title: 'Fishing', description: 'Whatever')
Skill.create!(title: 'Killing', description: 'Whatever')
Skill.create!(title: 'Building', description: 'Whatever')
Skill.create!(title: 'Hacking', description: 'Whatever')
Skill.create!(title: 'Annoying', description: 'Whatever')

puts 'Adding job examples...'
50.times do |n|
  title = "Job Example \##{n}"
  description = lorem
  Job.create!(title: title, description: description)
end

puts 'Links the first two jobs with some skills...'
JobSkill.create!(job: Job.first, skill: Skill.first)
JobSkill.create!(job: Job.first, skill: Skill.second)
JobSkill.create!(job: Job.first, skill: Skill.third)
JobSkill.create!(job: Job.second, skill: Skill.fourth)

puts 'Links the first user with some skills...'
UserSkill.create!(user: User.first, skill: Skill.first)
UserSkill.create!(user: User.first, skill: Skill.second)
UserSkill.create!(user: User.first, skill: Skill.third)
UserSkill.create!(user: User.first, skill: Skill.fourth)
