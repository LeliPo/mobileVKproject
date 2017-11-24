//
//  MyWallController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
//import AlamofareImage




class MyWallController: UITableViewController {

    var newsMy = [Wall]()
    let newsRequest = WallRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadData()
        
        newsRequest.loadWallSearchData() {
            [weak self] in
            self?.loadData()
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsMy.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWallCell", for: indexPath) as! MyWallCell
        let newsOne = newsMy[indexPath.row]
        
        var autorName = ""
        var autorAvatarUrl = ""
        if let group = newsOne.group {
            autorName = group.name
            autorAvatarUrl = group.photo
        } else if let user = newsOne.user {
            autorName = user.firstName + user.lastName
            autorAvatarUrl = user.photoAvatar
        }
        
        cell.textNews.text = newsOne.text
        cell.nameFriendNews.text = autorName
        cell.countLike.text = String(describing: newsOne.likesCount)
        cell.countComents.text = String(describing: newsOne.commentsCount)
        cell.countRepost.text = String(describing: newsOne.repostsCount)
        cell.viewsCount.text = String(describing: newsOne.likesCount)
        
        let mainPhotoUrl = newsOne.photoLink
        print (mainPhotoUrl)
      if mainPhotoUrl != nil {
        guard let imgURL = URL(string: mainPhotoUrl!) else {return cell}
            Alamofire.request(imgURL).responseData { (response) in
                cell.photoNews.image = UIImage(data: response.data!)}
        } else {
            cell.photoNews.image = nil
        }

        guard let imgURL = URL(string: autorAvatarUrl) else {return cell}
        Alamofire.request(imgURL).responseData { (response) in
        cell.fotoFriendsNews.image =  UIImage(data: response.data!)
        }
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathCurrent = tableView.indexPathForSelectedRow
        let yourNews = String(newsMy[(indexPathCurrent?.row)!].id)
        userDefaults.set(yourNews, forKey: "yourNews")
    }

    func loadData() {
        do {
            let realm = try Realm()
            let news = realm.objects(Wall.self)
            self.newsMy = Array(news)
        } catch {
            print(error)
        }
    }
}
