//
//  LaunchManager.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

class LaunchManager {
  fileprivate var urlComponents: URLComponents?
  
  /// environment can be set using scheme data or xcconfig
  fileprivate var environment: Environment
  fileprivate var path: String
  
  private init() {
    environment = Environment.production
    path = "launches"
  }
  
  static let shared = LaunchManager()
  
  ///
  /// Get upcoming launches
  ///
  /// - Parameters:
  ///   - completion: Result enum for handling API Response
  ///
  func get(_ launchType: LaunchType, limit: Int = 20, offset: Int = 1, completion: @escaping (Result<[Launch], LaunchRequestError>) -> Void) {
    
    //set url components
    urlComponents = environment.apiURLComponents
    switch launchType {
    case .upcoming:
      urlComponents?.path = "/v3/\(path)/upcoming"
      urlComponents?.queryItems = []
      
      let queryItemLimit = URLQueryItem(name: "limit", value: String(limit))
      let queryLimitOffset = URLQueryItem(name: "offset", value: String(offset))
      
      urlComponents?.queryItems?.append(queryItemLimit)
      urlComponents?.queryItems?.append(queryLimitOffset)
    case .next:
      urlComponents?.path = "/v3/\(path)/next"
    }
    
    //get url
    guard let url = urlComponents?.url else {
      completion(.failure(.badRequest))
      return
    }
    
    //create url session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    //generate request from url
    let request = Utilities.request(for: url, usingHttpMethod: "GET", withHeaders: nil)
    let task = session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.serverError))
        return
      }
      
      guard let data = data,
        let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode) else {
          completion(.failure(.serverError))
          return
      }
      
      do {
        switch launchType {
        case .next:
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          let launch = try decoder.decode(Launch.self, from: data)
          completion(.success([launch]))
        case .upcoming:
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          let launches = try decoder.decode([Launch].self, from: data)
          completion(.success(launches))
        }
        
      } catch {
        completion(.failure(.serializationError))
      }
    }
    
    task.resume()
  }
}

/// Handle API Errors for Movie Kind
enum LaunchRequestError: Error {
  case badRequest
  case serverError
  case serializationError
}

/// Different launch types
enum LaunchType {
  case upcoming
  case next
}
