class Ceasedesistbot < Chatterbot::Bot
  IGNORE_LIST = ['wikisext']

 def sync_following!
    follower_names = client.followers.select { |u| !u.protected? }.map(&:screen_name)
    friend_names = client.friends.map { |u| u.screen_name }

    to_follow = (follower_names - IGNORE_LIST) - friend_names
    to_unfollow = friend_names - follower_names

    client.unfollow(*to_unfollow)
    client.follow(*to_follow)

    nil
  end

end
