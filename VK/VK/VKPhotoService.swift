//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class PhotosRequest {
    
    private let syncQueue = DispatchQueue(label: "photoServis", qos: .userInteractive)
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    private var images = [String: UIImage]()
    
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        Alamofire.request(url).responseData(queue: syncQueue) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            self?.images[url] = image
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
            
        }
    }
//    let baseURL = "https://api.vk.com"
//    typealias loadPhotoDataCompletion = ([Photo]) -> Void
//
//    func loadPhotosData(completion: @escaping () -> () ) {
//        let path = "/method/photos.get"
//        let url = baseURL + path
//
//        let parameters: Parameters = [
//            "owner_id": userDefaults.string(forKey: "whoIsYourFriend") ?? print("No ID"),
//            "album_id": "profile",
//            "rev":"1",
//            "count": "200",
//            "version": "5.68"
//        ]
//
//        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
//            guard let data = response.value else { return }
//            let json = JSON(data)
//            let photos = json["response"].flatMap { Photo(json: $0.1 ) }
//            self.saveFriendsData(photos, count: photos.count)
//        }
//    }
//
//    func saveFriendsData(_ photos: [Photo], count: Int) {
//        do {
//            let realm = try Realm()
//            let oldPhotos = realm.objects(Photo.self)
//            realm.beginWrite()
//            if oldPhotos.count != count { realm.delete(oldPhotos) }
//            realm.add(photos)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
//
}


fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}


extension PhotosRequest {
     class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
     class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
