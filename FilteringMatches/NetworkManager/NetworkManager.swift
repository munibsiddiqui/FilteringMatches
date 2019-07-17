//
//  NetworkManager.swift
//  FilteringMatches
//
//  Created by Gaditek on 16/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation

class NetworkManager {

    let baseURL = "http://my-json-server.typicode.com/munibsiddiqui/mobile-test/"
  
  static let sharedInstance = NetworkManager()
  static let getMatches = "matches"
  
  func getAllUser(onSuccess:@escaping([User])-> Void, onFailure: @escaping(Error)-> Void){
    
    let url : String = baseURL + NetworkManager.getMatches
    let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "GET"
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
      
      if(error != nil){
        onFailure(error!)
      } else{
        
        let decoder = JSONDecoder()
        if let result = try? decoder.decode([User].self, from: data!){
          onSuccess(result)
        }
        
      }
      
    })
    
    task.resume()
    
  }
  
 
}
