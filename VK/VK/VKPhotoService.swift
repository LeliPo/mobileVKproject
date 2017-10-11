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
    let baseURL = "https://api.vk.com"
    typealias loadPhotoDataCompletion = ([Photo]) -> Void
    
    func loadPhotosData(completion: @escaping () -> () ) {
        let path = "/method/photos.get"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "owner_id": userDefaults.string(forKey: "whoIsYourFriend") ?? print("No ID"),
            "album_id": "profile",
            "rev":"1",
            "count": "200",
            "version": "5.68"
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.value else { return }
            let json = JSON(data)
            let photos = json["response"].flatMap { Photo(json: $0.1 ) }
            self.saveFriendsData(photos, count: photos.count)
            completion()
        }
    }
    
    func saveFriendsData(_ photos: [Photo], count: Int) {
        do {
            let realm = try Realm()
            let oldPhotos = realm.objects(Photo.self)
            realm.beginWrite()
            if oldPhotos.count != count { realm.delete(oldPhotos) }
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}


