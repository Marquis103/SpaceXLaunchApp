//
//  ViewController.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/16/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import UIKit

class LaunchTableViewController: UITableViewController {
  // MARK: - Properties
  var viewModel: LaunchListViewModel?
  
  // MARK: - Initializers
  convenience init(viewModel: LaunchListViewModel? = LaunchListViewModel()) {
    self.init(style: .plain)
    self.viewModel = viewModel
  }
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.tableFooterView = UIView()
  }
}

