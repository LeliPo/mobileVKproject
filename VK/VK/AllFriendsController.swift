//
//  AllFriendsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class AllFriendsController: UITableViewController {
    let vkService = VKLoginService()
    var token = ""
    var myFrends = [VKFriendsService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fuck
        vkService.getFrends() { [weak self] myFrends in
            self?.myFrends = myFrends
            self?.tableView?.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFrends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllFrendsCell", for: indexPath) as! AllFriendsCell
        
    
        cell.idFrend = myFrends[indexPath.row].id
        cell.friendsNamee.text = myFrends[indexPath.row].firstName + " " + myFrends[indexPath.row].lastName
        cell.friendsAvatar?.setImageFromURl(stringImageUrl: myFrends[indexPath.row].smallPhotoURL)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMyFrend" {
            let cell = sender as! AllFriendsCell
            let selectedFrend = myFrends.filter({ $0.id == cell.idFrend })
            
            if selectedFrend.count == 0 {
                fatalError()
            }
            let fotoMyFrendCollectionViewController = segue.destination as! FotoMyFrendCollectionViewController
            fotoMyFrendCollectionViewController.firstName = selectedFrend[0].firstName
            fotoMyFrendCollectionViewController.lastName = selectedFrend[0].lastName
            fotoMyFrendCollectionViewController.bigPhotoURL = selectedFrend[0].bigPhotoURL
        }
    }
}
