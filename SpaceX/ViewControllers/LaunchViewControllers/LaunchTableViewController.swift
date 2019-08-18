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
  var viewModel: LaunchListViewModel
  
  // MARK: - Initializers
  init(viewModel: LaunchListViewModel = LaunchListViewModel()) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.subscribe()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.resultsDidChange = nil
  }
  
  // MARK: - Helper Functions
  fileprivate func subscribe() {
    viewModel.resultsDidChange = { [weak self] launchType, launches in
      switch launchType {
      case .upcoming:
        self?.tableView.reloadData()
      case .next:
        break
      }
    }
  }
  
  fileprivate func setHeader() {
    
  }
}

