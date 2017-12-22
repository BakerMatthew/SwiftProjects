//
//  ImageViewController.swift
//  FlickrSearch
//
//  Created by Matt Baker on 2/18/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var flickrPhoto: FlickrPhoto!
    
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set photo title
        imageTitle.text = flickrPhoto!.title
        
        //Setup imageURL
        // URL Format: "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{size}.jpg"
        var imageURL = "https://farm"
        imageURL += String(flickrPhoto!.farm)
        imageURL += ".staticflickr.com/"
        imageURL += flickrPhoto!.serverID
        imageURL += "/"
        imageURL += flickrPhoto!.ID
        imageURL += "_"
        imageURL += flickrPhoto!.secret
        imageURL += "_"
        imageURL += "z"  // SIZE z: medium 640, 640 on longest side
        imageURL += ".jpg"
        
        //Set Image
        let url = URL(string: imageURL)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
                guard let imageData = try? Data(contentsOf: url!)
                    else { return }
                
                DispatchQueue.main.async {
                    self.imagePhoto?.image = UIImage(data: imageData)
                }
        })            

        task.resume()
    }
}
