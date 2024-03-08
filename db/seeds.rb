# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'n_cafe@example.com',
  password: 'n_cafe1'
  )
  
seats_data = [ ["T1", 4], ["T2", 2], ["T3", 2], ["T4", 2], ["C1", 1], ["C2", 1], ["C3", 1] ]
seats_data.each do |data|
  Seat.create!(name: data[0], limit_number: data[1])
end

reservation_time_data = [ ["10:00", "10:29"], ["10:30", "10:59"], ["11:00", "11:29"], ["11:30", "11:59"], ["12:00", "12:29"], ["12:30", "12:59"], ["13:00", "13:29"], ["13:30", "13:59"], ["14:00", "14:29"], ["14:30", "14:59"], ["15:00", "15:29"], ["15:30", "15:59"], ["16:00", "16:29"], ["16:30", "16:59"], ["17:00", "17:29"], ["17:30", "17:59"] ]
reservation_time_data.each do |data|
  ReservationTime.create!(start_at: data[0], end_at: data[1])
end

Customer.create!(
  last_name: 'admin',
  first_name: 'admin',
  last_name_kana: 'アドミン',
  first_name_kana: 'アドミン',
  email: 'n_cafe@example.com',
  password: 'n_cafe1',
  telephone_number: '00000000000'
  
  )