//
//  ImageData.swift
//  PhotoLibrary
//
//  Created by Matt Baker on 2/29/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit
import RealmSwift

class ImageData: Object {
    dynamic var location = ""
    dynamic var title = ""
    dynamic var photo: Data?
}
