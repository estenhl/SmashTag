import SmashTwitter
import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetTextLabel: UILabel?
    @IBOutlet weak var tweetScreenNameLabel: UILabel?
    @IBOutlet weak var tweetCreatedLabel: UILabel?
    @IBOutlet weak var tweetProfileImageView: UIImageView?
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let tweet = tweet {
            tweetScreenNameLabel?.text = tweet.user.screenName
            
            if let tweetTextLabel = tweetTextLabel {
                setTweetTextLabel(tweetTextLabel, tweet: tweet)
            }
            
            if let dateLabel = tweetCreatedLabel {
                let formatter = NSDateFormatter()
                
                if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                } else {
                    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
                }
                dateLabel.text = formatter.stringFromDate(tweet.created)
            }
            
            if let profileImage = tweet.user.profileImageURL {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                    [weak self] in
                    if let data = NSData(contentsOfURL: profileImage),
                       let tweetProfileImageView = self?.tweetProfileImageView {
                        dispatch_async(dispatch_get_main_queue()) {
                            tweetProfileImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    private func setTweetTextLabel(textLabel: UILabel, tweet: Tweet) {
        let attributedString = NSMutableAttributedString(string: tweet.text)
        addAttributesFromMentions(tweet.urls, to: attributedString, forIndexableString: tweet.text)
        addAttributesFromMentions(tweet.hashtags, to: attributedString, forIndexableString: tweet.text)
        addAttributesFromMentions(tweet.userMentions, to: attributedString, forIndexableString: tweet.text)
        textLabel.attributedText = attributedString
    }
    
    private func addAttributesFromMentions(mentions: [Mention]?, to string: NSMutableAttributedString, forIndexableString indexableString: String) {
        if let mentions = mentions {
            for mention in mentions {
                let location = mention.range.startIndex
                let length = mention.range.endIndex - 1 - mention.range.startIndex
                string.addAttribute(NSBackgroundColorAttributeName,
                                    value: mention.color.colorWithAlphaComponent(0.5),
                                    range: NSRange(location: location, length: length))
            }
        }
    }
}
