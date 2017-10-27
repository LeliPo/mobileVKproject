//
//  FotoFriendsViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
//import AlamofireImage
import Alamofire
import RealmSwift


class FotoMyFrendCollectionViewController: UICollectionViewController {
    
        var userId = 0
    
    var environment: Environment {
        return EnvironmentImp.Debug()
    }
    
    lazy var photoService = PhotoService(container: collectionView!)
    
    lazy var friendService: FriendService? = {
        guard let tabs = navigationController?.tabBarController as? Tabs else { return nil}
        let FriendService = FriendService(environment: EnvironmentImp.Debug(), token: tabs.token)
        return FriendService
    }()
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showUPhoto()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! FotoFriendsViewCell
        
        
        cell.fotoFrend.image = photoService.photo(atIndexpath: indexPath, byUrl: photos[indexPath.row].url)
    
        return cell
    }
    
    func showUPhoto() {
        friendService?.downloadPhoto(forUser: userId) { [weak self] photos in
            self?.photos = photos
            self?.collectionView?.reloadData()
        }
    }
}


