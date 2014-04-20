# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Populates professor list from seed_data/professors.txt
puts 'Populating professor list...'

File.readlines("#{Rails.root}/db/seed_data/professors.txt").each do |line|

  line.strip! # trim whitespace

  next if line.chars.first == '#' # Skip if line is a comment

  # Otherwise, add professor to the database if they are not in it already
  Instructor.where(pawprint: line, email: "#{line}@missouri.edu").first_or_create

end

puts 'Done populating professor list'

