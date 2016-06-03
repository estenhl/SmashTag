import UIKit
import SmashTwitter

class TweetViewController: UITableViewController {
    private struct TweetSections {
        static let ImageSection = 0
        static let UrlSection = 1
        static let HashtagSection = 2
        static let UserMentionSection = 3
    }
    var tweet: Tweet? {
        didSet {
            title = tweet?.text
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TweetSections.ImageSection: return 1
        case TweetSections.UrlSection: return countMentions(tweet?.urls)
        case TweetSections.HashtagSection: return countMentions(tweet?.hashtags)
        case TweetSections.UserMentionSection: return countMentions(tweet?.userMentions)
        default: return 0
        }
    }∫
    
    private func countMentions(mentions: [Mention]?) -> Int {
        if let count = mentions?.count {
            return count
        }
        return 0
    }
}
