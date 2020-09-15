//
//  Photo.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo : NSObject {
    
    var farm : Int?
    var server : Int?
    var id : Int?
    var secret : String?
    var title : String?
    
    override init() {
        
    }
    init(parametersJson: JSON)
    {
        self.farm = parametersJson["farm"].intValue
        self.server = parametersJson["server"].intValue
        self.id = parametersJson["id"].intValue
        self.secret = parametersJson["secret"].stringValue
        self.title = parametersJson["title"].stringValue
    }
}
extension Photo {

  func imageURL() -> String {
    return "https://farm\(farm!).static.flickr.com/\(server!)/\(id!)_\(secret!).jpg"
  }

}
