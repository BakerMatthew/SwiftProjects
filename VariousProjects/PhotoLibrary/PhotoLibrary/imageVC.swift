//
//  imageVC.swift
//  PhotoLibrary
//
//  Created by Matt Baker on 2/29/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit
import RealmSwift

class imageVC: UIViewController {
    
    var imageData: ImageData!
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageLocation: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Location: \(imageData.location) , Title: \(imageData.title)");
        
        //Set image
        userImage.image = UIImage(data: imageData.photo! as Data)
        
        //Set location
        imageLocation.text = imageData.location
        
        //Set Title
        imageTitle.text = imageData.title
    }
    
}
