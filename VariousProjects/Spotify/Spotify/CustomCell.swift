//
//  CustomCell.swift
//  Spotify
//
//  Created by Matt Baker on 2/05/16.
//  Copyright © 2016 USU. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell
{

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var imageName: UIImageView!
    
    //Set CustomCell Information
    var setSpotifyTrack: SpotifyTrack?
    {
        didSet
        {
            //Song Title
            songName?.text = setSpotifyTrack?.title
            
            //Artist
            artistName?.text = setSpotifyTrack?.artist
            
            //Image
            let imageURL = setSpotifyTrack?.image
            let url = URL(string: imageURL!)
            
            //Start image download on queue: task
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
                let imageData = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async
                {
                    self.imageName?.image = UIImage(data: imageData!)
                }
            }).resume()
        }
    }
}
