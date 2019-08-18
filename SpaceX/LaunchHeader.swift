//
//  LaunchHeader.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import UIKit

class LaunchHeader: UIView {
  fileprivate var nextLaunch: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate var missionName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  fileprivate var countDownLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var launch: Launch? {
    didSet {
      configureView()
    }
  }
  
  //MARK: - Helper functions
  fileprivate func configureView() {
    nextLaunch.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40.0).isActive = true
    nextLaunch.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    countDownLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    countDownLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    missionName.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40.0).isActive = true
    missionName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
}
