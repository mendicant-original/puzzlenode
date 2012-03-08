require 'faker'
require_relative '../faker/puzzle'
require_relative '../faker/date'

namespace :db do
  namespace :seed do
    include Faker::Puzzle
    include Faker::Date

    desc "Seeds the database with fake puzzle, user, annoucenment, and submission data"
    task :all => [:users, :puzzles, :announcements, :submissions, :comments]

    desc "Seed database with fake puzzle data"
    task :puzzles => :environment do

      10.times do
        date = sometime_last_year
        name = fake_title

        Puzzle.create!(
          name:              name,
          short_description: fake_sentence,
          description:       fake_description,
          created_at:        date,
          updated_at:        date,
          created_by:        fake_name,
          notice:            fake_sentence,
          released_on:       sometime_next_fortnight(date),
          published:         true,
          slug:              Slugger.generate(name)
        )
      end

      puts "10 puzzles created"
    end

    desc "Seed database with fake user data"
    task :users => :environment do

      50.times do
        date = sometime_last_year

        User.create!(
          name:       fake_name,
          email:      fake_email,
          nickname:   fake_nickname,
          created_at: date,
          updated_at: date
        )
      end

      puts "50 users created"
    end

    desc "Seed database with fake announcement data"
    task :announcements => :environment do

      admins = User.where(:admin => true)

      User.first.update_attribute(:admin, true) if admins.empty?

      10.times do
        date = sometime_last_year

        Announcement.create!(
          author_id:  admins.sample.id,
          title:      fake_title,
          body:       fake_paragraphs,
          created_at: date,
          updated_at: date
        )
      end

      puts "10 announcements created"
    end

    desc "Seed database with fake submission data"
    task :submissions => :environment do
      puzzles = Puzzle.where('published = true')

      if puzzles.empty?
        fail "Puzzles must be created before submissions can be seeded"
      end

      # Disable correctness validation - correctness will be set arbitrarily
      Submission.reset_callbacks(:create)

      puzzles.each do |puzzle|
        users = User.where('created_at > ?', puzzle.released_on)

        users.each do |user|
          # Some users will not attempt to solve
          next unless rand(2) == 1

          attempt_at = puzzle.released_on

          # Give each user a few solution attempts
          4.times do
            correct = rand(2) == 1

            submission = Submission.new(
              user_id:    user.id,
              puzzle_id:  puzzle.id,
              correct:    correct,
              created_at: attempt_at,
              updated_at: attempt_at
            )
            submission.save(validate: false)

            attempt_at = sometime_next_week(attempt_at)
            break if correct || attempt_at > Date.today
          end
        end
      end
    end

    desc "Seed database with fake comment data"
    task :comments => :environment do
      submissions = Submission.correct.sample(20)

      if submissions.empty?
        fail "Submissions must be created before comments can be seeded"
      end

      submissions.each do |submission|
        Comment.create!(
          user_id:    submission.user_id,
          puzzle_id:  submission.puzzle_id,
          body:       fake_paragraphs,
          created_at: submission.created_at,
          updated_at: submission.created_at
        )
      end

      puts "20 comments made"
    end

  end

  desc "Nuke data!"
  task :nuke => :environment do
    Announcement.delete_all
    Comment.delete_all
    Puzzle.delete_all
    Submission.delete_all
    User.delete_all('admin = false')
  end


end
