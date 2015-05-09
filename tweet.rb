class TweetGenerator
  SIGIL = '###'
  LEGAL_PHRASES = [
    "Dear Sir/Madam: As you are no doubt aware, \"#{SIGIL}\" is a trademark used to identify products and services related to our organization.",
    "Dear Sir/Madam: The words and phrases of \"#{SIGIL}\" are exclusively used by our organization. Other use constitutes trademark infringement.",
    "Dear Sir/Madam: It has come to our attention that our trademark \"#{SIGIL}\" appears as a metatag, keyword, or hidden text on this account.",
    "Dear Sir/Madam: Prior written authorization from our Client has not been obtained for use of \"#{SIGIL}\".",
    "Dear Sir/Madam: By using the trademark \"#{SIGIL}\", you have attempted to attract Internet users to your tweet or other online locations.",
    "Dear Sir/Madam: Please remove trademark \"#{SIGIL}\" from this Online Location. We will continue to monitor your domain for compliance.",
    "Dear Sir/Madam: We are notifying you of proprietary rights for the famous trademark \"#{SIGIL}\". Please remove it from this Online Location.",
    "Dear Sir/Madam: Be advised that our organization is the owner of the well-known trademark and trade name \"#{SIGIL}\".",
    "Dear Sir/Madam: Please remove trademark \"#{SIGIL}\" from this Online Location. Be assured that we will monitor you to verify compliance.",
    "Dear Sir/Madam: Please remove uses of \"#{SIGIL}\" or we will be forced to defer this issue to our \"#{SIGIL}\" Lawyer.",
    "Dear Sir/Madam: We demand that you remove all uses of \"#{SIGIL}\" no later than within three days of your receipt of this letter.",
    "Dear Sir/Madam: Use of \"#{SIGIL}\" infringes on personal rights in violation of the \"#{SIGIL}\" Personal Rights Protection Act of 1984.",
    "Dear Sir/Madam: We are entitled to recover from you the damages suffered as a result of your use of \"#{SIGIL}\".",
    "Dear Sir/Madam: You have created a likelihood of confusion with the \"#{SIGIL}\" trademark by using \"#{SIGIL}\".",
    "Dear Sir/Madam: For the avoidance of doubt, this infringing 'tweet' exploits the name/trademark \"#{SIGIL}\".",
    "Dear Sir/Madam: This infringing 'tweet' is NOT authorized by, affiliated with or otherwise endorsed by THE ESTATE OF \"#{SIGIL}\".",
    "Dear Sir/Madam: The above use of \"#{SIGIL}\" may (or may not as applicable) constitute criminal infractions or money laundering.",
    "Dear Sir/Madam: I am the Associate IP Coordinator for \"#{SIGIL}\" and I am authorized to act on behalf of its owners."
  ]
  MIN_TRADEMARK_LENGTH = 5

  def initialize(text)
    @source_text = text
  end

  def generate_tweet
    phrase = LEGAL_PHRASES.sample
    number_of_trademarks = phrase.scan(SIGIL).count
    max_length = (140 - phrase.gsub(SIGIL, '').length) / number_of_trademarks
    LEGAL_PHRASES.sample.gsub(SIGIL, get_trademark(max_length))
  end

private
  def get_trademark(max_length)
    singles = split_and_strip(@source_text, 1)
    pairs = split_and_strip(@source_text, 2)
    triples = split_and_strip(@source_text, 3)
    combos = singles + pairs + triples
    combos.select do |w|
      (w.length >= MIN_TRADEMARK_LENGTH) && (w.length <= max_length)
    end.max { |a, b| a.length <=> b.length }
  end

  def strip_inner_punctuation(grams)
    grams.reject { |x| /[a-zA-Z ]+[?.!;,][a-zA-Z ]+/.match(x) }
  end

  def strip_special_chars(grams)
    grams.map { |x| x.gsub(/[\.;:?!,]$/, '').gsub(/^[@#]/, '') }
  end

  def split_and_strip(str, gram_length)
    strip_special_chars(
      strip_inner_punctuation(
        str.split.each_cons(gram_length).map { |s| s.join(' ') }
      )
    )
  end

end
