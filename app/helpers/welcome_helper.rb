module WelcomeHelper
  def prepare_tweet(tweet)
    split_tweet = tweet.split
    split_tweet.each_with_index do |val,i|
      if val.starts_with? 'http'
        split_tweet[i] =  link_to val,val
      end
    end
    split_tweet.join(' ')
  end
end
