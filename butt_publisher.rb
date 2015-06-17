require 'chatterbot'
require 'faraday'
require 'json'
require 'engtagger'
require 'tempfile'
require './how2butt.rb'

class ButtPublisher
  def initialize
    @logger = Logger.new('/tmp/how2butt.log')
    @logger.debug 'Starting bot'
  end

  def find_title
    url = 'http://www.wikihow.com/api.php?action=query&list=random&rnnamespace=0&rnlimit=1&format=json'
    response = connection.get(url)
    JSON.parse(response.body)['query']['random'].first['title']
  end

  def improve_title(original_title)
    title = 'How to ' + original_title
    tagger = EngTagger.new
    tagged_words = tagger.add_tags(title).split(' ').shuffle
    if word = tagged_words.shuffle.find { |w| w.start_with?('<nn>', '<nnp>') }
      title.gsub!(word[/>(.*?)</, 1], 'Butt')
      title.gsub(' an Butt', ' a Butt')
    elsif word = tagged_words.shuffle.find { |w| w.start_with?('<nns>', '<nnps>') }
      title.gsub!(word[/>(.*?)</, 1], 'Butts')
      title.gsub(' an Butt', ' a Butt')
    else
      return improve_title(original_title)
    end
    title
  end

  def image_file(title)
    article = connection.get("http://www.wikihow.com/#{title.gsub(' ', '-')}")
    image_url = article.body.match(/<meta name="twitter:image:src" content="(.+?)"/)[1]
    return nil if image_url == 'http://www.wikihow.com/skins/WikiHow/images/wikihow_large.jpg'
    image = connection.get(image_url)

    file = Tempfile.new('image.jpg')
    file.write(image.body)
    file
  end

  def publish_tweet
    original_title = find_title
    title = improve_title(original_title)
    file = image_file(original_title)
    if file
      bot.client.update_with_media(title, file.open)
    else
      publish_tweet
    end
  end

  def connection
    @conn ||= Faraday.new
  end

  def bot
    @bot ||= How2butt.new
  end

  def debug
    @debug ||= bot.config[:debug]
  end
end
