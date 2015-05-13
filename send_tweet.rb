require 'chatterbot'
require './tweet.rb'
require './ceasedesistbot.rb'
require './botlogger.rb'

def valid_tweet?(bot_username, tweet)
  !(tweet.retweet? || bot_username == tweet.user.screen_name)
end

bot = Ceasedesistbot.new
logger = BotLogger.new(bot.botname)
debug = bot.config[:debug]

logger.debug "Starting bot"

bot.home_timeline do |source_tweet|
  logger.tweet_attempt(source_tweet)

  unless valid_tweet?(bot.botname, source_tweet)
    logger.debug "Tweet invalid: #{source_tweet.id}"
    break
  end

  source_text = source_tweet.text
  source_username = source_tweet.user.screen_name

  new_tweet_text = TweetGenerator.new(source_text, source_username).generate_tweet

  unless new_tweet_text.nil?
    logger.debug "Got a result: #{new_tweet_text}. Replying."

    unless debug
      bot.reply new_tweet_text, source_tweet
    end

    break
  end

  logger.debug "No text generated from #{tweet.id}, moving on"

end

logger.done
