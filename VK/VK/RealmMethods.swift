//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func replaceAllObjectOfType<T: Object>(toNewObjects objects: [T]) {
        do {
            let realm = try Realm()
            let oldObjects =  realm.objects(T.self)
            
            realm.beginWrite()
            realm.delete(oldObjects)
            realm.add(objects)
            
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}



