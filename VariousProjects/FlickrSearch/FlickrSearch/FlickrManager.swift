//
//  FlickrManager.swift
//  FlickrSearch
//
//  Created by Matt Baker on 2/18/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit

class FlickrManager
{
    static let flickrBaseAPI = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2724b9c5fb28143434db07e6a47d8112&sort=relevance&format=json&nojsoncallback=true&text="
    
    static func search(_ query: String, completion: @escaping (_ photos: [FlickrPhoto]) -> Void) {
        //Finalize the url with the user's query input
        guard let extraQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let flickrUrl = URL(string: flickrBaseAPI + extraQuery)
            else { return }
        
        let task = URLSession.shared.dataTask(with: flickrUrl, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Error: \(error!._code.description)")
                    return
                }
                
                var json: [String: AnyObject]
                do {
                    json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                } catch {
                    return
                }
                
                let photos = parsePhotosFrom(json)
                completion(photos)
        })            

        task.resume()
    }
    
    static func parsePhotosFrom(_ json: [String: AnyObject]) -> [FlickrPhoto] {
        var photos = [FlickrPhoto]()
        guard let jsonPhotos = json["photos"] as? [String: AnyObject],
            let jsonSinglePhoto = jsonPhotos["photo"] as? [[String: AnyObject]]
            else { return photos }
        
        for singlePhoto in jsonSinglePhoto {
            photos.append(FlickrPhoto(JSONitem: singlePhoto, size: "n"))
        }
        return photos
    }
}
