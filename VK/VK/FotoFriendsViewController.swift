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
    
    var photos = [Photo]()
    let photosRequest = PhotosRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        photosRequest.loadPhotosData() { [weak self] in
            self?.loadData()
            self?.collectionView?.reloadData()
        }
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
        
        guard let imgURL = URL(string: photo.photo) else { return cell }
        //    cell.photo.af_setImage(withURL: imgURL) // хранит в кэше фотки, память течёт
        Alamofire.request(imgURL).responseData { (response) in
            cell.fotoFrend.image = UIImage(data: response.data!)
        }
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


