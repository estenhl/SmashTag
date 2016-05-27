import SmashTwitter
import UIKit

class TweetTableViewController: UITableViewController {
    private var api: TwitterAPI?
    
    var tweets = [[Tweet]] () {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? = "#Test" {
        didSet {
            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }
    
    private var searchTextHistory = [String]()
    
    private struct TwitterSearchConstants {
        static let count = 20
    }
    
    private struct StoryBoard {
        static let TweetCellIdentifier = "Tweet"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = TwitterAPI(credentialType: TwitterCredentials.CredentialType.FromFile)
        print("View did load")
        searchForTweets()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tweets.count {
            return tweets[section].count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.TweetCellIdentifier, forIndexPath: indexPath)
        let tweet = tweets[indexPath.section][indexPath.row]
        
        if let tweetCell = cell as? TweetCell {
            print("Found tweet cell!")
            tweetCell.tweet = tweet
        }
        return cell
    }
    
    private func searchForTweets() {
        if let searchString = searchText {
            searchTextHistory.insert(searchString, atIndex: 0)
            /*
            TwitterAPI.searchForTweets(searchString, withCount: TwitterSearchConstants.count)
            { [weak weakSelf = self] newTweets in
                print("Found \(newTweets.count) new tweets")
                dispatch_async(dispatch_get_main_queue()) {
                    if let lastSearch = weakSelf?.searchTextHistory.first
                       where lastSearch == searchString && !newTweets.isEmpty {
                        print("Adding new tweets")
                        weakSelf?.tweets.insert(newTweets, atIndex: 0)
                    }
                }
            }
             */
        }
    }
}