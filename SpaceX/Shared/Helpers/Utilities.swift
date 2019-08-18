//
//  Utilities.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

class Utilities {
  ///
  /// Creates an URLRequset object for a given url, using a specfied http method,
  /// and with a collection of headers.
  ///
  /// Parameters:
  ///   - `url`: URL used to generate request
  ///   - `method`: Http method used for request. (defaults to "GET")
  ///   - `headers`: Addtional headers for request
  ///
  static func request(for url: URL, usingHttpMethod method: String, withHeaders headers: [String: String?]?) -> URLRequest {
    //create request
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    //set required headers
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    headers?.forEach { key, val in
      request.setValue(val, forHTTPHeaderField: key)
    }
    
    return request
  }
}
