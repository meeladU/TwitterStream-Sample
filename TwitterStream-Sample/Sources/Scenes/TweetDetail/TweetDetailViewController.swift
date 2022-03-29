//
//  TweetDetailViewController.swift
//  TwitterStream-Sample
//
//  Created by Milad Jabbarzade on 3/29/22.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    var tweetObject: TweetModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(tweetObject)
    }
    
    private func setupView(_ model: TweetModel?) {
        descriptionLabel.text = model?.text
    }
    

}
