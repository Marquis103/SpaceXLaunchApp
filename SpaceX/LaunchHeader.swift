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
    label.textColor = UIColor.spaceBlue
    label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    return label
  }()
  
  fileprivate var countDownLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .spaceBlue
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    guard let launchDate = launchDate else { return }
    countDownLabel.text = DateFormatUtility.shared.interval(date: launchDate)
  }
  
  fileprivate var timer = Timer()
  fileprivate var launchDate: Date? {
    didSet {
      setNeedsLayout()
    }
  }
  
  var launch: Launch? {
    didSet {
      if let launch = launch {
        configureView()
        runTimer()
        nextLaunch.text = "🚀 \(launch.rocket.rocketName) for mission \(launch.missionName) launches in ..."
        launchDate = launch.launchDate
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(nextLaunch)
    self.addSubview(countDownLabel)
    
    self.backgroundColor = UIColor.groupTableViewBackground
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Helper functions
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
    self.launchDate = launch?.launchDate
  }
  
  fileprivate func configureView() {
    nextLaunch.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20.0).isActive = true
    nextLaunch.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    countDownLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    countDownLabel.topAnchor.constraint(equalTo: nextLaunch.bottomAnchor, constant: 16.0).isActive = true
    countDownLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
  }
}
