require 'chatterbot'
require './ceasedesistbot.rb'

bot = Ceasedesistbot.new
bot.home_timeline(count: 1) do |tweet|
  reply TweetGenerator.new(tweet.text).generate_tweet, tweet
  bot.config[:since_id] = tweet.id
end