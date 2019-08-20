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
  var launchDate: Date
  var rocket: Rocket
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.flightNumber = try values.decode(Int.self, forKey: .flightNumber)
    self.missionName = try values.decode(String.self, forKey: .missionName)
    self.missionId = try values.decodeIfPresent([String].self, forKey: .missionId) ?? []
    self.launchDate = try values.decode(Date.self, forKey: .launchDate)
    self.rocket = try values.decode(Rocket.self, forKey: .rocket)
  }
}

extension Launch {
  enum CodingKeys: String, CodingKey {
    case flightNumber = "flight_number"
    case missionName = "mission_name"
    case missionId = "mission_id"
    case rocket = "rocket"
    case launchDate = "launch_date_local"
  }
}
