//
//  LaunchTableViewCell.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/17/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
  // MArK: - TableView Cell subviews
  fileprivate lazy var missionnName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
    return label
  }()
  
  fileprivate lazy var missionIds: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    return label
  }()
  
  fileprivate lazy var rocketName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    return label
  }()
  
  fileprivate lazy var reusedPieces: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    return label
  }()
  
  fileprivate lazy var missionTime: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    return label
  }()
  
  // MARK: - Properties
  var launch: Launch? {
    didSet {
      configureView()
    }
  }
  
  ///
  /// Configure Tableview cell for given launch
  ///
  private func configureView() {
    guard let launch = launch else { return }
    
    self.contentView.addSubview(missionnName)
    self.contentView.addSubview(missionTime)
    self.contentView.addSubview(reusedPieces)
    self.contentView.addSubview(rocketName)
    
    missionnName.text = launch.missionName
    missionTime.text = "mission time"
    reusedPieces.text = "♻️ 3 reused cores ♻️"
    rocketName.text = "rocketname"
    
    let safeAreaLayoutGuide = self.contentView.safeAreaLayoutGuide
    
    // layout mission name
    missionnName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    missionnName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    
    // date of launch
    missionTime.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    missionTime.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    
    // if mission ids are available add the label
    if launch.missionId.isEmpty {
      rocketName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
      rocketName.topAnchor.constraint(equalTo: missionnName.bottomAnchor, constant: 12.0).isActive = true
    } else {
      self.contentView.addSubview(missionIds)
      
      //set mission= id texts
      missionIds.text = "\(launch.missionId.split(separator: ","))"
      
      missionIds.topAnchor.constraint(equalTo: missionnName.bottomAnchor, constant: 4.0).isActive = true
      missionIds.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
      rocketName.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 12.0).isActive = true
      rocketName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    reusedPieces.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    reusedPieces.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 4.0).isActive = true
  }
}
