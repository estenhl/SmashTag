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
        print("Updating UI")
        if let tweet = tweet {
            print("Found text \(tweet.text)")
            tweetTextLabel?.text = tweet.text
            tweetScreenNameLabel?.text = tweet.user.screenName
            
            if let dateLabel = tweetCreatedLabel {
                let formatter = NSDateFormatter()
                
                if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                } else {
                    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
                }
                dateLabel.text = formatter.stringFromDate(tweet.created)
            }
        }
    }
}
