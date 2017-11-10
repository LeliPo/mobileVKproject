//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMethods {
    
    func saveItemData<T>(_ item: T) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(item as! Object)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func deleteItemData<T>(_ item: T) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(item as! Object)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func tableUpdate<T>(_ items: inout Results<T>, _ token: inout NotificationToken, _ tableView: UITableView) {
        do {
            let realm = try Realm()
            items = realm.objects(T.self)
            token = items.addNotificationBlock { (changes: RealmCollectionChange) in
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
extension RealmMethods {
    
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

