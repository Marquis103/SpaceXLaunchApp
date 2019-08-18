//
//  Launch.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

class Launch: Decodable {
  var flightNumber: Int
  var missionName: String
  var missionId: [String]
  var launchYear: String
  var launchDateUTC: Date
}

extension Launch {
  static var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
}
