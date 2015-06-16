require 'chatterbot'
require './butt_publisher.rb'
require './how2butt.rb'

bot = How2butt.new
log = Logger.new("/tmp/#{bot.botname}.log")
log.level = Logger::DEBUG

log.debug 'Starting bot'
bot.publish_tweet
