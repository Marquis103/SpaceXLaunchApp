//
//  Environment.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

private struct EnvironmentConstants {
  private init (){}
  
  static var productionScheme     = "https"
  static var productionAPIHost    = "api.spacexdata.com/v3"
}

///
/// Environemnt builds URL paths for a given url in a particular environment.
///
enum Environment: String, CustomStringConvertible {
  case production
  case staging
  case development
  
  init(platform: String) {
    switch platform {
    case Environment.production.rawValue:
      self = .production
    case Environment.staging.rawValue:
      self = .staging
    case Environment.development.rawValue:
      self = .development
    default:
      self = .production
    }
  }
  
  /// API URL for different environemnts
  var apiURLComponents: URLComponents? {
    switch self {
    case .production:
      var urlComponents = URLComponents()
      urlComponents.scheme = EnvironmentConstants.productionScheme
      urlComponents.host = EnvironmentConstants.productionAPIHost
      return urlComponents
    default: return nil
    }
  }
  
  var description: String {
    switch self {
    case .production: return "production"
    case .staging: return "staging"
    case .development: return "development"
    }
  }
}
