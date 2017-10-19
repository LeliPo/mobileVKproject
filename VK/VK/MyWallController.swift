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

   var newsMy : Results<Wall>?
    let newsRequest = WallRequest()
    var token:  NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   loadData()
       pairTableAndRealm()
        
//        newsRequest.loadWallSearchData() {
//            [weak self] in
//            self?.loadData()
//            self?.tableView.reloadData()
    //}
        //tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsMy?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWallCell", for: indexPath) as! MyWallCell
        let newsOne = newsMy![indexPath.row]
        cell.textNews.text = newsOne.text
        
  
        
        guard let imgURL = URL(string: newsOne.photo) else {return cell}
        Alamofire.request(imgURL).responseData { (response) in
            cell.fotoNews.image = UIImage(data: response.data!)
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathCurrent = tableView.indexPathForSelectedRow
        let yourNews = String(newsMy![(indexPathCurrent?.row)!].newsID)
        userDefaults.set(yourNews, forKey: "yourNews")
    }

//    func loadData() {
//        do {
//            let realm = try Realm()
//            let news = realm.objects(Wall.self)
//            self.newsMy = Array(news)
//        } catch {
//            print(error)
//        }
//    }
    
    func  pairTableAndRealm() {
        do {
            let realm = try Realm()
            newsMy = realm.objects(Wall.self)
            token = newsMy?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
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
