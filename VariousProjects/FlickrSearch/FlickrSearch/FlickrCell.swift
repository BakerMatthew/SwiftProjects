//
//  FlickrCell.swift
//  FlickrSearch
//
//  Created by Matt Baker on 2/18/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit

class FlickrCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    var setFlickrPhoto: FlickrPhoto? {
        didSet {
            //Setup imageURL
            // URL Format: https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{size}.jpg
            var imageURL = "https://farm"
            imageURL += String(setFlickrPhoto!.farm)
            imageURL += ".staticflickr.com/"
            imageURL += setFlickrPhoto!.serverID
            imageURL += "/"
            imageURL += setFlickrPhoto!.ID
            imageURL += "_"
            imageURL += setFlickrPhoto!.secret
            imageURL += "_"
            imageURL += setFlickrPhoto!.size
            imageURL += ".jpg"
			
			//let imageURL = "https://farm\(String(setFlickrPhoto!.farm)).staticflickr.com/\(setFlickrPhoto!.serverID)/\(setFlickrPhoto!.ID)_\(setFlickrPhoto!.secret)_\(setFlickrPhoto!.size).jpg"
            
            //Set Image
            let url = URL(string: imageURL)
            
            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
                guard let imageData = try? Data(contentsOf: url!)
                    else { return }
                    
                DispatchQueue.main.async {
                    self.photo?.image = UIImage(data: imageData)
                }
            })                

            task.resume()
        }
    }
    
}
