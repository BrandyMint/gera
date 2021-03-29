ENV['SCHEMA'] = Rails.root.join('db', ['schema', ActiveRecord::Base.configurations[Rails.env]['adapter'], 'rb'].join('.')).to_s

puts "Use database adapter: #{ActiveRecord::Base.configurations[Rails.env]['adapter']}"
