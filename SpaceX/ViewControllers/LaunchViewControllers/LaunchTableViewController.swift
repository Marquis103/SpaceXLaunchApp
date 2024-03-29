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
  
  fileprivate var headerView: LaunchHeader?
  
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
    
    //set up tableview
    self.navigationItem.title = "Upcoming Launches"
    self.tableView.rowHeight = 140.0
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorStyle = .none
    self.tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.identifier)
    
    let frame = CGRect(x: self.tableView.frame.minX, y: self.tableView.frame.minY, width: self.view.frame.width, height: 175)
    headerView = LaunchHeader(frame: frame)
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
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .next:
        DispatchQueue.main.async {
          self?.headerView?.launch = launches.first
          self?.tableView.tableHeaderView = self?.headerView
        }
      }
    }
  }
  
  // MARK: - Data Source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.launches.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.identifier, for: indexPath)
    cell.selectionStyle = .none
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let cell = cell as? LaunchTableViewCell
    cell?.launch = viewModel.launches[indexPath.row]
  }
}

