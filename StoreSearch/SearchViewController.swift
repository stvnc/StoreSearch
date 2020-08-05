//
//  SearchViewController.swift
//  StoreSearch
//
//  Created by Vincent Angelo on 05/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "SearchCell"
    
    var hasSearched = false
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Fake Results
    
    var searchResults = [String]() {
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
    
    
    // MARK: - Helpers
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "This is a search bar"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    func configureTableView(){
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }


}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        
        cell.resultLabel.text = searchResults.count == 0 ? "Nothing Found" : searchResults[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched { return 0 }
        
        return searchResults.count == 0 ? 1 : searchResults.count
    }
}

extension SearchViewController: UISearchResultsUpdating{
func updateSearchResults(for searchController: UISearchController) {
    searchResults = []
    let searchText = searchController.searchBar.text!
    
    if searchText != nil {
        
    for i in 0...searchText.count {
        searchResults.append(String("Fake Result \(searchText) no \(i)"))
    }
        
    } else {
        hasSearched = false
    }
    
    hasSearched = true
    print("Search text: \(searchController.searchBar.text)")
    }
    
}
