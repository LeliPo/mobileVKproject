//
//  AllFriendsController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class AllFriendsController: UITableViewController {
    
    let friendRequest = AllFriendsController()
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      loadData()
  
         friendRequest.loadFriendsData() { [weak self] in
          self?.loadData()
          self?.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllFrendsCell", for: indexPath) as! AllFriendsCell
        let friend = friends[indexPath.row]
        
        cell.friendsNamee.text = friend.firstName + " " + friend.lastName
        guard let imgURL = URL(string: friend.photoAvatar) else {return cell}
        Alamofire.request(imgURL).responseData { (response) in
            cell.friendsAvatar.image = UIImage(data: response.data!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathCurrent = tableView.indexPathForSelectedRow
        let whoIsYourFriend = String(friends[(indexPathCurrent?.row)!].userID)
        userDefaults.set(whoIsYourFriend, forKey: "whoIsYourFriend")
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let friends = realm.objects(Friend.self)
            self.friends = Array(friends)
        } catch {
            print(error)
        }
    }
}
