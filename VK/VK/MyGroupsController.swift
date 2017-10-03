//
//  MyGroupsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {

    let vkService = VKLoginService()
    
    var myGroups = [VKGroupsService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vkService.getMyGroups( ){ [weak self] myGroups in
            self?.myGroups = myGroups
            self?.tableView?.reloadData()
        }
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
        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell

        cell.nameMyGroup.text = myGroups[indexPath.row].name
        cell.avatarMyGroup?.setImageFromURl(stringImageUrl: myGroups[indexPath.row].photoURL)
        
        return cell
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            
            let allGroupsController = segue.source as! AllGroupsController
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                
                //let selectGroup = allGroupsController.allGroups[indexPath.row]
//                if !myGroups.contains(where: {$0.nameGroup == selectGroup.nameGroup}) {
//                    //allGroupsController.allGroups[indexPath.row].countMember += 1
//                    myGroups.append(selectGroup)
//                    tableView.reloadData()
//                }
            }
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
