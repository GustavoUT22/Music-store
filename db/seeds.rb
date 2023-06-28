# frozen_string_literal: true

require 'faker'

puts 'Clear database'
AlbumOrder.destroy_all
SongAlbum.destroy_all
Order.destroy_all
Song.destroy_all
Album.destroy_all
Customer.destroy_all
Artist.destroy_all

# Restaurar los id's de la base de datos
ActiveRecord::Base.connection.reset_pk_sequence!('album_orders')
ActiveRecord::Base.connection.reset_pk_sequence!('song_albums')
ActiveRecord::Base.connection.reset_pk_sequence!('orders')
ActiveRecord::Base.connection.reset_pk_sequence!('songs')
ActiveRecord::Base.connection.reset_pk_sequence!('albums')
ActiveRecord::Base.connection.reset_pk_sequence!('customers')
ActiveRecord::Base.connection.reset_pk_sequence!('artists')

puts 'Create new artists'
10.times do |_number|
  date = Faker::Date.birthday(min_age: 18, max_age: 65)
  artist = Artist.create(
    name: Faker::Music::RockBand.name,
    nationality: Faker::Nation.nationality,
    birth_date: date,
    death_date: date.next_year(rand(1..17)),
    biography: Faker::Lorem.paragraph(sentence_count: rand(4..10))
  )

  if artist.save
    print '.'
  else
    puts "\nF\n#{artist.errors.full_messages.join(', ')}"
  end
end

puts "\nCreate new customers"
15.times do |_number|
  customer = Customer.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "#{Faker::Internet.password(min_length: 6)}#{rand(1..9)}",
    name: Faker::Name.name
  )
  if customer.save
    print '.'
  else
    puts "\nF\n #{customer.errors.full_messages.join(', ')}"
  end
end

puts "\nCreate new records"
10.times do |artist_count| # En el primer recorrido artist_count = 0
  rand(2..6).times do |_album_count|
    album_duration = 0

    # Create Albums
    puts "\nCreate new albums"
    album = Album.create(
      name: Faker::Music.album,
      price: rand(500..2000)
    )
    if album.save
      print '.'
    else
      puts "\nF\n#{album.errors.full_messages.join(', ')}"
    end

    # Create Songs
    rand(4..10).times do |_number|
      duration = rand(200..500)
      puts "\nCreate new songs"
      song = Song.create(
        name: Faker::Music::RockBand.song,
        duration:,
        artist_id: artist_count + 1
      )
      album_duration += duration
      if song.save
        print '.'
      else
        puts "\nF\n#{song.errors.full_messages.join(', ')}"
      end

      # Create SongAlbum records
      puts "\nCreate new song_album"
      song_album = SongAlbum.create(
        song_id: song.id,
        album_id: album.id
      )

      if song_album.save
        print '.'
      else
        puts "\nF\n#{song_album.errors.full_messages.join(', ')}"
      end
    end

    # Update Albums
    puts "\nUpdate album_duration to albums"
    album.update(album_duration:)
  end
end

puts "\nCreate new records"
15.times do |customer_count| # En el primer recorrido customer_count = 0
  rand(1..5).times do |_order_count|
    total_price = 0
    # Create Order
    puts "\nCreate new orders"
    order = Order.create(
      order_date: Faker::Date.between(from: '2020-01-01', to: '2023-04-14'),
      customer_id: customer_count + 1
    )
    if order.save
      print '.'
    else
      puts "\nF\n#{order.errors.full_messages.join(', ')}"
    end

    # Create AlbumOrder
    rand(1..4).times do |_number|
      album = Album.all.sample
      quantity = rand(1..3)
      album_order = AlbumOrder.new(
        album_id: album.id,
        order_id: order.id,
        quantity:
      )
      total_price += album.price * quantity
      if album_order.save
        print '.'
      else
        puts ''
        puts 'F'
        puts album_order.errors.full_messages.join(', ')
      end
    end

    # Update Order
    puts "\nUpdate total_price to orders"
    order.update(total_price:)
  end
end
