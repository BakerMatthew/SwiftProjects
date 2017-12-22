//
//  FlickrPhoto.swift
//  FlickrSearch
//
//  Created by Matt Baker on 2/18/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit

class FlickrPhoto {
    var farm = 0
    var serverID = ""
    var ID = ""
    var secret = ""
    var size = ""
    var title = ""
    
    // SIZES
    // m: small, 240 on longest side
    // n: small, 320 on longest side
    // z: medium 640, 640 on longest side
    
    init(JSONitem: [String: AnyObject], size: String?) {
        //Parse farm
        guard let farm = JSONitem["farm"] as? Int
            else { return }
        self.farm = farm
        
        //Parse serverID
        guard let serverID = JSONitem["server"] as? String
            else { return }
        self.serverID = serverID
        
        //Parse ID
        guard let ID = JSONitem["id"] as? String
            else { return }
        self.ID = ID
        
        //Parse secret
        guard let secret = JSONitem["secret"] as? String
            else { return }
        self.secret = secret
        
        //Set size
        self.size = size!
        
        //Set title
        guard let title = JSONitem["title"] as? String
            else { return }
        self.title = title
    }
    
}
