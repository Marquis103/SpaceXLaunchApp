//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: launchTableViewController)
    
    return true
  }
}

extension AppDelegate {
  ///
  /// Root view controller
  ///
  fileprivate var launchTableViewController: LaunchTableViewController {
    let tableViewController = LaunchTableViewController(viewModel: nil)
    return tableViewController
  }
}

