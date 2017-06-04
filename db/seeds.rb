# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
Skill.create!(title:       'Programming',
              description: 'Some text tahalsdf lasdfj',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/programmer.png"))


#File.new("#{Rails.root}/path/to/somefile.jpg")

Skill.create!(title:       'Journalist',
              description: 'Whatever',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/journalist.png"))

Skill.create!(title:       'Driving',
              description: 'Whatever',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/chauffer.png"))

Skill.create!(title:       'Painting',
              description: 'Whatever',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/painter.png"))

Skill.create!(title:       'Graphic Design',
              description: 'Whatever',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/graphic-designer.png"))

Skill.create!(title:       'Sewing',
              description: 'Whatever',
              image:       File.new("#{Rails.root}/app/assets/images/111826-people-skills/png/seamstrees.png"))


puts 'Adding job examples...'
Job.create!(title: 'Web developer ninja needed',
            description: 'We are in need of a super awesome web developer to help expand our team and develop awesome websites as well as fight crime at night.')

Job.create!(title: 'Batman', description: 'Literally Batman. We need you to save Gotham!')

puts 'Links jobs with skills...'
JobSkill.create!(job: Job.first, skill: Skill.first, level: 8)
JobSkill.create!(job: Job.first, skill: Skill.second, level: 2)
JobSkill.create!(job: Job.first, skill: Skill.third, level: 1)

JobSkill.create!(job: Job.second, skill: Skill.first, level: 10)
JobSkill.create!(job: Job.second, skill: Skill.third, level: 10)

puts 'Links users with skills...'
UserSkill.create!(user: User.first, skill: Skill.first, level: 3)
UserSkill.create!(user: User.first, skill: Skill.second, level: 1)
UserSkill.create!(user: User.first, skill: Skill.third, level: 5)
UserSkill.create!(user: User.first, skill: Skill.fourth, level: 2)

UserSkill.create!(user: User.third, skill: Skill.first, level: 10)
