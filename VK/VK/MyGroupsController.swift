//
//  MyGroupsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Realm


class MyGroupsController: UITableViewController {

    var myGroups : Results<Group>?
    var token: NotificationToken?
    var realm = RealmMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVersusRealm()

        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell

        guard let group = myGroups?[indexPath.row] else {
            cell.nameGroupMy.text = ""
            return cell
        }
        cell.nameGroupMy.text = group.name
        
        guard let imgURL = URL(string: group.photo) else { return cell }
        Alamofire.request(imgURL).responseData { (response) in
            cell.avatarMyGroup.image = UIImage(data: response.data!)
        }
        return cell
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupsController = segue.source as! AllGroupsController
            guard let indexPath = allGroupsController.tableView.indexPathForSelectedRow else { return }
            let group = allGroupsController.groups[indexPath.row]
            if isContains(group) {
                realm.saveItemData(group)
            }
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
             guard let deletedGroup = myGroups?[indexPath.row] else { return }
             realm.deleteItemData(deletedGroup)
        }
    }
    func isContains(_ group: Group) -> Bool {
        var result = true
        if let groups = myGroups {
            for value in groups {
                if group.groupID == value.groupID {
                    result = false
                }
            }
        }
        return result
    }

    func tableVersusRealm() {
        do {
            let realm = try Realm()
            myGroups = realm.objects(Group.self)
            token = myGroups?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.endUpdates()
                    
                case .error(let error):
                    fatalError("\(error)")
                    break
                }
            }
        } catch {
            print(error)
        }
    }
}
