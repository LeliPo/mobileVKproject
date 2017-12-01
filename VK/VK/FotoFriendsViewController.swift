//
//  FotoFriendsViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class FotoMyFrendCollectionViewController: UICollectionViewController {
    
    var photos = [Photo]()
    lazy var photosRequest = PhotosRequest(container: self.collectionView!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
//        photosRequest.loadPhotosData() { [weak self] in
//            self?.loadData()
//                self?.collectionView?.reloadData()
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FotoMyFrendCell", for: indexPath)
            as! FotoFriendsViewCell
        
        let photo = photos[indexPath.row]
        print(photo)
        cell.fotoFrend.image = photosRequest.photo(atIndexpath: indexPath, byUrl: photos[indexPath.row].photo)
        
        return cell
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let photos = realm.objects(Photo.self)
            self.photos = Array(photos)
        } catch {
            print(error)
        }
    }
}


