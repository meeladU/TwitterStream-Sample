//
//  TweetListViewController.swift
//  TwitterStream-Sample
//

import UIKit
import DifferenceKit

protocol TweetListViewControllerProtocol: AnyObject {
    typealias Section = ArraySection<String, TweetModel>
    func showActivityIndicator()
    func hideActivityIndicator()
    func didRetriveNewFeeds(with section: Section)
    func didRetriveFeedsFailed(with errorDescription: String)
    func didSetRuleFailed(with errorDescription: String)
}

class TweetListViewController: UIViewController {
    
    typealias Section = ArraySection<String, TweetModel>
    private var data = [Section]()
    public var dataInput: [Section] {
        get { return data }
        set {
            let changeset = StagedChangeset(source: data, target: newValue)
            tweetListView?.tableView.reload(using: changeset, with: .fade) { data in
                self.data = data
            }
        }
    }
    
    var tweetListView: TweetListView?
    var interactor: TweetListInteractorInput?
    var router: TweetListRouterInput?
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        view = tweetListView

        tweetListView?.searchBar.delegate = self
        tweetListView?.tableView.dataSource = self
        tweetListView?.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tweetListView?.searchBar.becomeFirstResponder()
    }
}

// MARK: General Methods
extension TweetListViewController {
    private func setupUI() {
        title = "Tweets"
    }
}

extension TweetListViewController: TweetListViewControllerProtocol {
    func didRetriveNewFeeds(with section: Section) {
        dataInput.insert(section, at: 0)
    }
    
    func hideActivityIndicator() {
        tweetListView?.hideIndicator()
    }
    
    func showActivityIndicator() {
        tweetListView?.showIndicator()
    }
    
    func didRetriveFeedsFailed(with errorDescription: String) {
        tweetListView?.hideIndicator()
        UIAlertController.showAlertWithOkButton(controller: self, strMessage: errorDescription, completion: nil)
    }

    func didSetRuleFailed(with errorDescription: String) {
        tweetListView?.hideIndicator()
        UIAlertController.showAlertWithOkButton(controller: self, strMessage: errorDescription, completion: nil)
    }
}

// MARK: - UITableView DataSource & Delegate
extension TweetListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier, for: indexPath) as? TweetCell
        cell?.tweetObject = data[indexPath.section].elements[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = data[indexPath.section].elements[indexPath.row]
        router?.routeToTweetDetailView(model: model)
    }
    
}

// MARK: - UISearchBarDelegate
extension TweetListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            searchBar.resignFirstResponder()
            dataInput.removeAll()
            interactor?.searchTweet(with: searchText)
            tweetListView?.showIndicator()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
