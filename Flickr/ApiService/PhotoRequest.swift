//
//  PhotoRequest.swift
//  Flickr
//
//  Created by Basma on 9/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Alamofire
import SwiftyJSON

class PhotoRequest : ParsePhotos {
   
    func requestPhotos(isRecent: Bool, searchText: String, completion:@escaping ([Photo]) -> ()) {
        var parameters = ""
        var method = ""
        if isRecent {
             method = "flickr.photos.getRecent"
        }else {
            method = "flickr.photos.search"
            parameters = "&text=\(searchText)"
        }
        let apiKey = ApiConstants.shared.apiKey
        let url = ApiConstants.baseURL + "?method=\(method)\(ApiConstants.format)\(parameters)&api_key=\(apiKey!)"
               print(url)
        getRequest(url: url, parameters: parameters) { (value) in
        let photos = self.parsePhotos(value: value)
        completion(photos)
      }
    }
    func getRequest(url : String, parameters: String, completion:@escaping (JSON) -> ()) {
      Alamofire.request(url, method: .get).validate().responseJSON { response in
        switch response.result {
          case .success(let value):
            completion(JSON(value))
          case .failure(let error):
            print("Failed request with given url: \(url)", error)
            completion(JSON.null)
        }
      }
    }
}
