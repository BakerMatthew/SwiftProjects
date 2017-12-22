//
//  SpotifyManager.swift
//  Spotify
//
//  Created by Matt Baker on 2/05/16.
//  Copyright © 2016 USU. All rights reserved.
//

import Foundation

class SpotifyManager {
    
    static let spotifyBaseAPI = "https://api.spotify.com/v1/search?&type=track&limit=50&q="
    
    static func search(_ query: String, completion: @escaping (_ tracks: [SpotifyTrack]) -> Void) {
        guard let escapedQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: spotifyBaseAPI + escapedQuery)
            else {
                return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
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
            
            let tracks = parseTracksFrom(json)
            completion(tracks)
        }) 
        task.resume()
    }
    
    static func parseTracksFrom(_ json: [String: AnyObject]) -> [SpotifyTrack] {
        var tracks = [SpotifyTrack]()
        guard let jsonTracks = json["tracks"] as? [String: AnyObject],
            let jsonItems = jsonTracks["items"] as? [[String: AnyObject]]
            else {
                return tracks
        }
        
        for jsonItem in jsonItems {
            tracks.append(SpotifyTrack(itemJSON: jsonItem))
        }
        return tracks
    }
    
}
