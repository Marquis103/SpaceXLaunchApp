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
  fileprivate lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .spaceBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //fileprivate var clipping
  fileprivate lazy var missionName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.textColor = UIColor.white
    label.lineBreakMode = .byWordWrapping
    label.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
    return label
  }()
  
  fileprivate lazy var missionIds: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    return label
  }()
  
  fileprivate lazy var rocketName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    return label
  }()
  
  fileprivate lazy var reusedPieces: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    return label
  }()
  
  fileprivate lazy var missionTime: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    return label
  }()
  
  // MARK: - Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .groupTableViewBackground
    
    //setup container
    self.contentView.addSubview(containerView)
    let safeAreaLayoutGuide = self.contentView.safeAreaLayoutGuide
    
    containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
    containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6.0).isActive = true
    containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6.0).isActive = true
    containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    
    //add subviews to container
    self.containerView.addSubview(missionName)
    self.containerView.addSubview(missionIds)
    self.containerView.addSubview(rocketName)
    self.containerView.addSubview(reusedPieces)
    self.containerView.addSubview(missionTime)
    
    // layout mission name
    let containerLayoutGuide = self.containerView.safeAreaLayoutGuide
    missionName.leadingAnchor.constraint(equalTo: containerLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
    missionName.topAnchor.constraint(equalTo: containerLayoutGuide.topAnchor, constant: 8.0).isActive = true
    missionName.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor).isActive = true
    
    missionIds.topAnchor.constraint(equalTo: missionName.bottomAnchor, constant: 4.0).isActive = true
    missionIds.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    
    rocketName.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    rocketName.topAnchor.constraint(equalTo: missionIds.bottomAnchor, constant: 12.0).isActive = true
    
    missionTime.bottomAnchor.constraint(equalTo: containerLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
    missionTime.leadingAnchor.constraint(equalTo: missionName.leadingAnchor).isActive = true
    
    reusedPieces.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    reusedPieces.bottomAnchor.constraint(equalTo: containerLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View Methods
  override func layoutSubviews() {
    super.layoutSubviews()
    
    containerView.layer.cornerRadius = 10
    containerView.layer.masksToBounds = false
    
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
    containerView.layer.shadowColor = UIColor.darkGray.cgColor
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
        rocketName.text = "\(launch.rocket.rocketName) 🚀"
        missionIds.text = !launch.missionId.isEmpty ? launch.missionId.joined(separator: ",") : nil
        
        let reusedCount = launch.rocket.reusedPiecesCount
        reusedPieces.text = reusedCount > 0 ? "♻️ \(reusedCount) reused cores" : nil
      }
    }
  }
}
