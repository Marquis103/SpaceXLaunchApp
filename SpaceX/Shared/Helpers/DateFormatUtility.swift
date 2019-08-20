//
//  DateFormatUtility.swift
//  SpaceX
//
//  Created by Marquis Dennis on 8/19/19.
//  Copyright © 2019 thatSwiftGuy. All rights reserved.
//

import Foundation

class DateFormatUtility {
  // MARK: - Initializers
  private init() { }
  
  static let shared = DateFormatUtility()
  
  // MARK: - DateFormatters
  fileprivate lazy var mediumDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    return dateFormatter
  }()
  
  // MARK: - Factory Method to get date format
  func dateFormat(forType type: DateFormatType) -> DateFormatter {
    switch type {
    case .mediumDateFormat: return mediumDateFormatter
    }
  }
}
  
enum DateFormatType {
  ///
  /// Returns a date formatter with a short date style format
  /// - Example date: "January 9, 1982 11:15 pm"
  ///
  case mediumDateFormat
}
