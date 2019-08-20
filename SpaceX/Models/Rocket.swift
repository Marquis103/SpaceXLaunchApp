//
//  Rocket.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
  var rocketId: String
  var rocketName: String
  
  fileprivate var cores: [Core]
  fileprivate var payloads: [Payload]
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    rocketName = try container.decode(String.self, forKey: .rocketName)
    rocketId = try container.decode(String.self, forKey: .rocketId)
    
    // first stage
    let firstStageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .firstStage)
    cores = try firstStageContainer.decode([Core].self, forKey: .cores)
    
    //second stage
    let secondStageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .secondStage)
    payloads = try secondStageContainer.decode([Payload].self, forKey: .payloads)
  }
  
  /// Number of reused pieces
  var reusedPiecesCount: Int {
    return cores.filter { $0.reused == true }.count + payloads.filter { $0.reused == true }.count
  }
}

extension Rocket {
  enum CodingKeys: String, CodingKey {
    case rocketId = "rocket_id"
    case rocketName = "rocket_name"
    case firstStage = "first_stage"
    case secondStage = "second_stage"
    case cores
    case payloads
  }
}


struct Core: Decodable {
  var reused: Bool
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    reused = try container.decodeIfPresent(Bool.self, forKey: .reused) ?? false
  }
}

extension Core {
  enum CodingKeys: String, CodingKey {
    case reused
  }
}


struct Payload: Decodable {
  var reused: Bool
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    reused = try container.decodeIfPresent(Bool.self, forKey: .reused) ?? false
  }
}

extension Payload {
  enum CodingKeys: String, CodingKey {
    case reused
  }
}

