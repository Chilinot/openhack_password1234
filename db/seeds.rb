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

User.create!(name:  'Example User',
             email: 'example@railstutorial.org',
             password:              'password72',
             password_confirmation: 'password72',
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password72"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

100.times do |n|
  title = "Job Example \##{n}"
  description = lorem
  Job.create!(title: title, description: description)
end
