namespace :test_data do
  desc 'Create dummy tasks'
  task tasks: :environment do
    user = User.with_role(:user).first

    admin = User.with_role(:admin).first

    fail('please run `bundle exec rake db:seed` before applying test data') unless user && admin

    10.times do
      user.tasks.create(name: Faker::Lorem.sentence,
                        description: Faker::Lorem.paragraphs.join(' '),
                        state: %w( new started finished).sample,
                        remote_attachment_url: Faker::Avatar.image)
    end

    5.times do
      admin.tasks.create(name: Faker::Lorem.sentence,
                         description: Faker::Lorem.paragraphs.join(' '),
                         state: %w( new started finished).sample,
                         remote_attachment_url: Faker::Avatar.image)
    end
  end
end
