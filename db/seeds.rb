user = User.find_or_initialize_by(email: "test@example.com")
user.assign_attributes(
  name: "テストユーザー",
  password: "password",
  password_confirmation: "password"
)
user.save!

rooms = 10.times.map do |i|
  room = Room.find_or_initialize_by(name: "テスト施設#{i + 1}")
  room.assign_attributes(
    user: user,
    description: "テスト用の施設#{i + 1}です。",
    price: (i + 1) * 1000,
    address: [ "東京", "大阪", "京都", "札幌" ][i % 4]
  )
  room.save!
  room
end

3.times do |i|
  check_in = Date.current + ((i + 1) * 7).days
  check_out = check_in + 2.days
  attendance = i + 1

  reservation = Reservation.find_or_initialize_by(
    user: user,
    room: rooms[i]
  )

  reservation.assign_attributes(
    check_in: check_in,
    check_out: check_out,
    attendance: attendance,
    sum_price: rooms[i].price * attendance * (check_out - check_in).to_i
  )

  reservation.save!
end
