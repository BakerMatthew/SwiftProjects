//
//  Item.swift
//  Spotify
//
//  Created by Matt Baker on 2/05/16.
//  Copyright © 2016 USU. All rights reserved.
//

import Foundation
import UIKit

class SpotifyTrack {
    
    var title = ""
    var artist = ""
    var previewUrl = ""
    var image = ""
    
    init(itemJSON: [String: AnyObject]) {
		// Title
        guard let title = itemJSON["name"] as? String
            else {
                return
        }
        self.title = title
		
		// Artist
        guard let artists = itemJSON["artists"] as? [[String: AnyObject]],
            let firstArtist = artists.first,
            let artist = firstArtist["name"] as? String
            else {
                return
        }
        self.artist = artist
		
		// Preview URL
		guard let previewUrl = itemJSON["preview_url"] as? String
			else {
				return
		}
		self.previewUrl = previewUrl

		// Album Image
        guard let album = itemJSON["album"] as? [String: AnyObject],
            let imageSelection = album["images"] as? [[String: AnyObject]],
            let firstImage = imageSelection.first,
            let image = firstImage["url"] as? String
            else {
                return
        } 
        self.image = image
    }
    
}
