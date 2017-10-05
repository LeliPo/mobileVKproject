//
//  FotoFriendsViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class FotoMyFrendCollectionViewController: UICollectionViewController {
    
    let vkService = VKLoginService()
    
    var firstName   = ""
    var lastName    = ""
    var bigPhotoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = firstName + " " + lastName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FotoMyFrendCell", for: indexPath)
            as! FotoFriendsViewCell
        
        cell.fotoFrend.setImageFromURl(stringImageUrl: bigPhotoURL)
        return cell
    }
}


