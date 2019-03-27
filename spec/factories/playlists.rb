FactoryBot.define do
    factory :follow do
        user
        playlist
      end

    factory :playlist do
        name { "MyPlaylist" }
        description { "This is a test playlist" }

        factory :playlist_with_follows do
            transient do
                follows_count { 3 }
            end

            after :create do |playlist, evaluator|
                create_list(:follow, evaluator.follows_count, playlist: playlist)
            end
        end
    end
  end
