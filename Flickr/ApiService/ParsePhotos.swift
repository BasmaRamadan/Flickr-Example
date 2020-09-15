//
//  ParsePhotos.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import SwiftyJSON
class ParsePhotos {
    
func parsePhotos(value: JSON) -> [Photo] {
    var photos: [Photo] = []
    let values = value["photos"]["photo"].arrayValue
    for photoValues in values{
        photos.append(Photo(parametersJson: photoValues))
    }
    return photos
    }
}
