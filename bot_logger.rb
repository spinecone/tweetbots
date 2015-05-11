require 'logger'

class BotLogger < Logger

  def initialize(botname)
    super("/tmp/#{botname}.log")
    @level = DEBUG
    @num_seen = 0
  end

  def tweet_attempt(tweet)
    @num_seen += 1
    debug "Trying to generate based on tweet id #{tweet.id}"
  end

  def done
    debug "Done processing home_timeline; processed #{@num_seen} tweets"
    @num_seen = 0
  end

end
