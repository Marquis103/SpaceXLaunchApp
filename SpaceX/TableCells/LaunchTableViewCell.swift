//
//  LaunchTableViewCell.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/17/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
  static let identifier = "launchTableViewCell"
  
  // MARK: - TableView Cell subviews
  fileprivate lazy var missionName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.lineBreakMode = .byWordWrapping
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    return label
  }()
  
  fileprivate lazy var missionIds: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    return label
  }()
  
  fileprivate lazy var rocketName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    return label
  }()
  
  fileprivate lazy var reusedPieces: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    return label
  }()
  
  fileprivate lazy var missionTime: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    return label
  }()
  
  // MARK: - Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(missionName)
    self.contentView.addSubview(missionIds)
    self.contentView.addSubview(rocketName)
    self.contentView.addSubview(reusedPieces)
    self.contentView.addSubview(missionTime)
    
    let safeAreaLayoutGuide = self.contentView.safeAreaLayoutGuide
    
    // layout mission name
    missionName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
    missionName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
    missionName.trailingAnchor.constraint(lessThanOrEqualTo: missionTime.leadingAnchor).isActive = true
    
    missionIds.topAnchor.constraint(equalTo: missionName.bottomAnchor, constant: 8.0).isActive = true
    missionIds.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    
    rocketName.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    rocketName.topAnchor.constraint(equalTo: missionIds.bottomAnchor, constant: 8.0).isActive = true
    
    reusedPieces.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    reusedPieces.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 8.0).isActive = true
    
    missionTime.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
    missionTime.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true

    missionName.trailingAnchor.constraint(lessThanOrEqualTo: missionTime.leadingAnchor).isActive = true
    missionTime.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.missionIds.text = nil
    self.missionName.text = nil
    self.reusedPieces.text = nil
    self.rocketName.text = nil
    self.missionTime.text = nil
  }
  
  // MARK: - Properties
  var launch: Launch? {
    didSet {
      if let launch = launch {
        missionName.text = launch.missionName
        missionTime.text = DateFormatUtility.shared.dateFormat(forType: .mediumDateFormat).string(from: launch.launchDate)
        rocketName.text = launch.rocket.rocketName
        missionIds.text = !launch.missionId.isEmpty ? launch.missionId.joined(separator: ",") : nil
        
        let reusedCount = launch.rocket.reusedPiecesCount
        reusedPieces.text = reusedCount > 0 ? "♻️ \(reusedCount) reused cores" : nil
      }
    }
  }
}
