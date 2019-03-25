# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mary = User.create(dj_name: "Mary")
djlonz = User.create(dj_name: "DJ Lonz")
adamg = User.create(dj_name: "Adam Gordaddy")
diz = mary.playlists.create(name: "Poppin Disney Playlist", description: "Dreams do come true", author_id: mary.id)
dreamz = mary.playlists.create(name: "Goes to Dreamworks", description: "She needed space", author_id: mary.id)
homemade = djlonz.playlists.create(name: "The Alfa Fonz", description: "Superhuman", author_id: djlonz.id)
daddy = adamg.playlists.create(name: "Dad Rock", description: "I beat Fortnite", author_id: adamg.id)
diz.songs.create(name: "Supercalafragilisticexpialidosous", artist: "Mary Poppins", genre: "Inspirational", year: 1962)
diz.songs.create(name: "Helloworld", artist: "DJ Khalid", genre: "Hip Hop Electronic", year: 1929)
