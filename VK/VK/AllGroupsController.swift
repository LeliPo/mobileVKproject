//
//  AllGroupsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    let vkService = VKLoginService()
    let delay = Delay()
    var filterGroups = [VKGroupsService]()
    
    @IBOutlet weak var searchBarView: UISearchBar!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.delegate = self
        searchBarView.returnKeyType = UIReturnKeyType.done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGroups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        
        if isSearching {
            cell.nameAllGroups.text = filterGroups[indexPath.row].name
            cell.imageView?.setImageFromURl(stringImageUrl: filterGroups[indexPath.row].photoURL)
            
            cell.countManinGroups.text = String(filterGroups[indexPath.row].membersCount)
           
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            delay.delayTime{ // выполняется задержка в 0,85 секунд при вводе, чтобы не отправлять запрос сразу
                self.vkService.searchGroups(searchText: searchBar.text!.lowercased()){ [weak self] filterGroups in
                    self?.filterGroups = filterGroups
                    self?.tableView?.reloadData()
                }
            }
        }
    }
}
