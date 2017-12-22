//
//  ImageCell.swift
//  PhotoLibrary
//
//  Created by Matt Baker on 2/29/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit
import RealmSwift

class ImageCell: UICollectionViewCell{
    
    @IBOutlet weak var photo: UIImageView!
    
    var setPhotoData: ImageData?{
        didSet{
            //Set photo's image
            self.photo?.image = UIImage(data: setPhotoData!.photo! as Data)
        }
    }
}
