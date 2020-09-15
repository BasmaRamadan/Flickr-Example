//
//  ApiConstants.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class ApiConstants : NSObject {
    
    static let shared = ApiConstants()
    
    var apiKey : String?
    var apiSecret : String?
    static let baseURL = "https://api.flickr.com/services/rest/"
    static let format = "&format=json&nojsoncallback=1"

    override init() {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            fatalError("You probably forgot to add a configuration file.. (see: SupportingFiles/Configuration.plist.example)")
          }

          guard let configDictionary = NSDictionary(contentsOfFile: path) else {
            fatalError("Something went wrong when loading configurion file..")
          }

          guard let apiKey = configDictionary["apiKey"] as? String,
            let apiSecret = configDictionary["apiSecret"] as? String else {
              fatalError("Something went wrong when loading apiKey/apiSecret..")
          }

          self.apiKey = apiKey
          self.apiSecret = apiSecret
        }
    }

