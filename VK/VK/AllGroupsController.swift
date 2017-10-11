//
//  AllGroupsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var groupsRequest = GroupsRequest()
    
    var groups = [Group]()
   
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        userDefaults.set(searchText, forKey: "whatYouSearch")
        
        groupsRequest.loadGroupSearchData() { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
//
//    @IBOutlet weak var searchBarView: UISearchBar!
//    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return groups.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        
        if isFiltering() {
            let group = groups[indexPath.row]
            cell.nameAllGroups.text  = group.name
            
            guard let imgURL = URL(string: group.photo) else { return cell }
            Alamofire.request(imgURL).responseData { (response) in
                cell.groupFhoto.image = UIImage(data: response.data!)
            
//            cell.countManinGroups.text = String(filterGroups[indexPath.row].membersCount)
           
        }
      }
        return cell
    }
}
extension AllGroupsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
