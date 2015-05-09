class TweetGenerator
  SIGIL = '###'
  LEGAL_PHRASES = [
    "As you are no doubt aware, \"#{SIGIL}\" is a trademark used to identify products and services related to our organization.",
    "The words and phrases of \"#{SIGIL}\" are exclusively used by our organization. Other use constitutes trademark infringement.",
    "It has come to our attention that our trademark \"#{SIGIL}\" appears as a metatag, keyword, or hidden text on this account.",
    "Prior written authorization from our Client has not been obtained for use of \"#{SIGIL}\".",
    "By using the trademark \"#{SIGIL}\", you have attempted to attract Internet users to your tweet or other online locations.",
    "Please remove trademark \"#{SIGIL}\" from this Online Location. We will continue to monitor your domain for compliance.",
    "We are notifying you of proprietary rights for the famous trademark \"#{SIGIL}\". Please remove it from this Online Location.",
    "Be advised that our organization is the owner of the well-known trademark and trade name \"#{SIGIL}\".",
    "Please remove trademark \"#{SIGIL}\" from this Online Location. Be assured that we will monitor you to verify compliance.",
    "Please remove uses of \"#{SIGIL}\" or we will be forced to defer this issue to our \"#{SIGIL}\" Lawyer.", 
    "We demand that you remove all uses of \"#{SIGIL}\" no later than within three days of your receipt of this letter.",
    "Use of \"#{SIGIL}\" infringes on personal rights in violation of the \"#{SIGIL}\" Personal Rights Protection Act of 1984.",
    "We are entitled to recover from you the damages suffered as a result of your use of \"#{SIGIL}\".",
    "You have created a likelihood of confusion with the \"#{SIGIL}\" trademark by using \"#{SIGIL}\".",
    "For the avoidance of doubt, this infringing 'tweet' exploits the name/trademark \"#{SIGIL}\".",
    "This infringing 'tweet' is NOT authorized by, affiliated with or otherwise endorsed by THE ESTATE OF \"#{SIGIL}\".",
    "The above use of \"#{SIGIL}\" may (or may not ­as applicable) constitute criminal infractions or money laundering.",
    "I am the Associate IP Coordinator for \"#{SIGIL}\" and I am authorized to act on behalf of its owners."
  ]
  MIN_TRADEMARK_LENGTH = 5

  def initialize(text, username)
    @source_text = text
    @username = "@#{username} "
  end

  def generate_tweet
    phrase = LEGAL_PHRASES.sample
    number_of_trademarks = phrase.scan(SIGIL).count
    max_length = (140 - phrase.gsub(SIGIL, '').length - @username.length) / number_of_trademarks
    @username + LEGAL_PHRASES.sample.gsub(SIGIL, get_trademark(max_length))
  end

  def get_trademark(max_length)
    # get list of single words and pairs of words
    single_and_pairs = @source_text.split + @source_text.split.each_cons(2).to_a.map { |p| p.join(' ') }
    single_and_pairs.select { |w| (w.length >= MIN_TRADEMARK_LENGTH) && (w.length <= max_length) }.sample
  end
end
