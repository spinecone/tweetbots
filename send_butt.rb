require 'chatterbot'
require './butt_publisher.rb'
require './how2butt.rb'

publisher = ButtPublisher.new
log = Logger.new('/tmp/how2butt.log')
log.level = Logger::DEBUG

log.debug 'Starting bot'
publisher.publish_tweet
