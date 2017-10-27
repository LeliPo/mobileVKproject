//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire





class PhotoService {
    
    private let syncQueue = DispatchQueue(label: "ru.jonfir.gbvk.photoService", qos: .userInteractive)
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
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {
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
