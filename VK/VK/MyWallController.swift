//
//  MyWallController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class NewsFeed: UITableViewController {
    
    
    var environment: Environment {
        return EnvironmentImp.Debug()
    }
    lazy var photoService = PhotoService(container: tableView)
  
    
    lazy var newsService: NewsService? = {
        guard let tabs = tabBarController as? Tabs else { return nil}
        let userService = NewsService(environment: environment, token: tabs.token)
        return userService
    }()
    
    var news = [Wall]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
        
        newsService?.downloadsNews() { [weak self] news in
            self?.news = news
            self?.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWallCell", for: indexPath) as! MyWallCell
        let new = news[indexPath.row]
        
        var autorName = ""
        var autorAvatarUrl = ""
        if let group = new.group {
            autorName = group.name
            autorAvatarUrl = group.photoUrl
        } else if let user = new.user {
            autorName = user.fullName
            autorAvatarUrl = user.photoUrl
        }
        
        if let mainPhotoUrl = new.photoLink {
            cell.photoNew.image = photoService.photo(atIndexpath: indexPath, byUrl: mainPhotoUrl)
        } else {
            cell.photoNew.image = nil
        }
        
        cell.autorAvatar.image = photoService.photo(atIndexpath: indexPath, byUrl: autorAvatarUrl)
        cell.autorName.text = autorName
        cell.textNew.text = new.text
        cell.likeCount.text = String(describing: new.likesCount)
        cell.commentCount.text = String(describing: new.commentsCount)
        cell.repostCount.text = String(describing: new.repostsCount)
        cell.viewsCount.text = String(describing: new.viewsCount)
        
        return cell
}
}
