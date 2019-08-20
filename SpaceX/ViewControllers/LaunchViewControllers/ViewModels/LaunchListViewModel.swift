//
//  LaunchListViewModel.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

class LaunchListViewModel {
  /// Types of launch data
  var nextLaunch: Launch? {
    didSet {
      if let nextLaunch = nextLaunch {
        resultsDidChange?(.next, [nextLaunch])
      }
    }
  }
  
  var launches: [Launch] = [Launch]() {
    didSet {
      resultsDidChange?(.upcoming, launches)
    }
  }
  
  ///display options for launch data
  var limit = 20
  var offset = 1 {
    didSet {
      fetch(.upcoming, limit: limit, offset: offset)
    }
  }
  
  /// Completion handler for launch API
  var resultsDidChange: ((LaunchType, [Launch]) -> Void)?
  
  init() {
    // fetch launch data
    fetch(.next)
    fetch(.upcoming)
  }
  
  /// Get launch data
  func fetch(_ launchType: LaunchType, limit: Int = 20, offset: Int = 1) {
    LaunchManager.shared.get(launchType, limit: limit, offset: offset) { [weak self] result in
      switch result {
      case .success(let launches):
        switch launchType {
        case .next:
          self?.nextLaunch = launches.first
        case .upcoming:
          self?.launches.append(contentsOf: launches)
        }
      case .failure(let failure):
        break
      }
    }
  }
}
