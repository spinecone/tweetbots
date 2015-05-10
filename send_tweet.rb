require 'chatterbot'
require './tweet.rb'
require './ceasedesistbot.rb'

bot = Ceasedesistbot.new
bot.home_timeline do |original_tweet|
  new_tweet_username = original_tweet.user.screen_name
  new_tweet_text = TweetGenerator.new(original_tweet.text, new_tweet_username).generate_tweet

  bot.config[:since_id] = original_tweet.id
  unless new_tweet_text.nil? || original_tweet.retweet? || new_tweet_username == bot.botname
    bot.reply new_tweet_text, original_tweet
    break
  end
end
