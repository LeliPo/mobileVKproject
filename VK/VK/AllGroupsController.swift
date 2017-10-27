//
//  AllGroupsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire

class SearchGroups: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    {
        didSet {
            searchBar.delegate = self
        }
    }
    
   var environment: Environment {
        return EnvironmentImp.Debug()
    }
    
    lazy var photoService = PhotoService(container: tableView)
    
    lazy var groupService: GroupService? = {
        guard let tabs = navigationController?.tabBarController as? Tabs else { return nil}
        let groupService = GroupService(environment: EnvironmentImp.Debug(), token: tabs.token)
        return groupService
    }()
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        
            let group = groups[indexPath.row]
            cell.nameAllGroups.text  = group.name
            cell.countManinGroups.text = String(group.count)
            cell.groupFhoto.image = photoService.photo(atIndexpath: indexPath, byUrl: group.photoUrl)
            
              return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = groups[indexPath.row].id
        groupService?.joinToGroup(groupID: id) { [weak self] in
            self?.performSegue(withIdentifier: "addGroup", sender: nil)
        }
    }
    
}

extension SearchGroups: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let text = searchBar.text,
            !text.isEmpty else {
                
                tableView.reloadData()
                return
        }
        searchGroups(request: text)
        tableView.reloadData()
    }
    
    func searchGroups(request: String) {
        groupService?.searchGroups(request: request) { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
}
