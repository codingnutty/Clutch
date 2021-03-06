# random users

User.create!(
        username: "admin",
        address_line_1: "633 Folsom",
        address_line_2: "6th Floor",
        city: "San Francisco",
        state: "CA",
        zip: "94107",
        email: "admin@admin.com",
        password: "adminadmin",
        avatar: "https://pbs.twimg.com/profile_images/2370446440/6e2jwf7ztbr5t1yjq4c5.jpeg",
        first_name: "Admin",
        last_name: "Istrator"
  )

50.times do
  User.create!(
        username: FFaker::Internet.user_name,
        address_line_1: FFaker::AddressUS.street_address,
        address_line_2: FFaker::AddressUS.secondary_address,
        city: FFaker::AddressUS.city,
        state: FFaker::AddressUS.state_abbr,
        zip: FFaker::AddressUS.zip_code,
        email: FFaker::Internet.disposable_email,
        password: FFaker::Internet.password,
        avatar: Faker::Avatar.image,
        first_name: FFaker::Name.first_name,
        last_name: Faker::Name.last_name
    )

end

#Admin events

5.times do
  random_size = rand(1..10)
  Event.create!(
        public_location: FFaker::Venue.name,
        address_line_1: FFaker::AddressUS.street_address,
        address_line_2: FFaker::AddressUS.secondary_address,
        city: FFaker::AddressUS.city,
        state: FFaker::AddressUS.state_abbr,
        zip: FFaker::AddressUS.zip_code,
        max_size: random_size,
        time_start: Faker::Time.between(DateTime.now - 1, DateTime.now),
        time_end: Faker::Time.forward(1),
        name: FFaker::Company.catch_phrase,
        description: FFaker::HipsterIpsum.phrase,
        category: FFaker::Sport.name,
        approval_required: FFaker::Boolean.sample,
        host_id: 1,
        status: FFaker::Boolean.sample
    )

end

# random events

100.times do
  random_size = rand(1..10)
  random_user = rand(1..User.count)
  Event.create!(
        public_location: FFaker::Venue.name,
        address_line_1: FFaker::AddressUS.street_address,
        address_line_2: FFaker::AddressUS.secondary_address,
        city: FFaker::AddressUS.city,
        state: FFaker::AddressUS.state_abbr,
        zip: FFaker::AddressUS.zip_code,
        max_size: random_size,
        time_start: Faker::Time.between(DateTime.now - 1, DateTime.now),
        time_end: Faker::Time.forward(1),
        name: FFaker::Company.catch_phrase,
        description: Faker::Hacker.say_something_smart,
        category: FFaker::Sport.name,
        approval_required: FFaker::Boolean.sample,
        host_id: random_user,
        status: FFaker::Boolean.sample
    )

end

# Admin comments

20.times do
  random_event = rand(1..Event.count)
  Comment.create!(
        event_id: random_event,
        user_id: 1,
        body: FFaker::BaconIpsum.phrase,
        is_private: FFaker::Boolean.sample
    )

end

# random comments (public and private)

200.times do
  random_event = rand(1..Event.count)
  random_user = rand(1..User.count)
  Comment.create!(
        event_id: random_event,
        user_id: random_user,
        body: FFaker::BaconIpsum.phrase,
        is_private: FFaker::Boolean.sample
    )

end

# random pending rsvps (id # 1-25)

100.times do
  random_guest = rand(10..User.count)
  random_event = rand(1..Event.count)
  new_event = Rsvp.create!(
      guest_id: random_guest,
      event_id: random_event,
      message: Faker::Hacker.say_something_smart,
      pending: true
    )

end

#Admin pending rsvps

10.times do
  random_event = rand(1..Event.count)
  new_event = Rsvp.create!(
      guest_id: 1,
      event_id: random_event,
      message: Faker::Hacker.say_something_smart,
      pending: true
    )

end

# Admin (not pending) rsvps

10.times do
  random_guest = rand(10..User.count)
  random_event = rand(1..Event.count)
  new_event = Rsvp.create!(
      guest_id: random_guest,
      event_id: random_event,
      message: Faker::Hacker.say_something_smart,
      pending: false,
      confirmed: FFaker::Boolean.sample
    )

end

# random not-pending rsvps (true and false; id #26-50)

100.times do

  random_guest = rand(10..User.count)
  random_host = rand(1..9)
  random_event = rand(1..Event.count)
  new_event = Rsvp.create!(
      guest_id: random_guest,
      event_id: random_event,
      pending: false,
      message: Faker::Hacker.say_something_smart,
      confirmed: FFaker::Boolean.sample
    )

end

# random confirmed rsvps (id #51-75)

100.times do

  random_guest = rand(10..User.count)
  random_host = rand(1..9)
  random_event = rand(1..Event.count)
  new_event = Rsvp.create!(
      guest_id: random_guest,
      event_id: random_event,
      pending: false,
      message: Faker::Hacker.say_something_smart,
      confirmed: true
    )

end

# random ratings (from confirmed rsvps)
150.times do
  count = 1
  current_event = Event.find(count)
      Rating.create!(
          event_id: count,
          rating: rand(1.0..5.0),
          rating_feedback: FFaker::HipsterIpsum.phrase,
          rater_id: current_event.host.id,
          ratee_id: current_event.guests.sample.id
        )
    count += 1
end

# random ratings (switched roles)

150.times do
  count = 1
  current_event = Event.find(count)
      Rating.create!(
          event_id: count,
          rating: rand(1.0..5.0),
          rating_feedback: FFaker::HipsterIpsum.phrase,
          ratee_id: current_event.host.id,
          rater_id: current_event.guests.sample.id
        )
    count += 1
end



