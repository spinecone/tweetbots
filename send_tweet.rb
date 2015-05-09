require 'chatterbot'
home_timeline do |tweet|
  reply TweetGenerator.new(tweet).generate_tweet, tweet
end