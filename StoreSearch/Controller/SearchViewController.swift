//
//  SearchViewController.swift
//  StoreSearch
//
//  Created by Vincent Angelo on 05/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "SearchCell"
    let nothingIdentifier = "NothingCell"
    
    var hasSearched = false
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Fake Results
    
    var searchResults = [SearchResult]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "StoreSearch"
        navigationController?.navigationBar.barStyle = .default
        
        
    }
    
    
    // MARK: - Helpers
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "This is a search bar"
        searchController.becomeFirstResponder()
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    func configureTableView(){
        tableView.insetsLayoutMarginsFromSafeArea = false
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(NothingCell.self, forCellReuseIdentifier: nothingIdentifier)
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "WHoops!", message: "There was an error accessing the iTunes store, please try again!.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NothingCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        
        cell.songLabel.text = searchResults[indexPath.row].name
        cell.artistLabel.text = searchResults[indexPath.row].artistName
        if let url = URL(string: searchResults[indexPath.row].storeURL ?? ""){
            cell.albumImage.sd_setImage(with: url, completed: nil)
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched || searchResults.count == 0 { return 0 }
        
        return searchResults.count
    }
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        searchResults = []
        hasSearched = true
        let searchText = searchController.searchBar.text!
        
        let url = Service.iTunesURL(searchText: searchText)
        
        if let jsonString = Service.performStoreRequest(with: url) {
            print("Received JSON string '\(jsonString)'")
        }
        print("URL: '\(url)'")
        
        if let data = Service.performStoreRequest(with: url) {  // Modified
            searchResults = Service.parse(data: data)
//            searchResults.sort { $0 < $1 }
            searchResults.sort(by: <)
            }
            // New line
        }
        //        else {
        //            let error = Service.showNetworkError()
        //            present(error, animated: true, completion: nil)
        //        }
        
    }
    
