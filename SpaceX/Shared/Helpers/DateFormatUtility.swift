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
  
  // default calendar
  private var calendar = Calendar.current
  
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
  
  ///
  /// Interval string from launch date to current date
  /// - Parameters:
  ///   - date: Future launch date compared to current date
  /// - Returns:
  ///   - String: (e.g) 23 days 12:10:54
  ///
  func interval(date: Date) -> String {
    let components = calendar.dateComponents([ .day, .hour, .minute, .second], from: Date(), to: date)
    let intervalString = String(format: "%02d days %02d:%02d:%02d",
                              arguments: [components.day ?? 0, components.hour ?? 0, components.minute ?? 0, components.second ?? 0])
    return intervalString
  }
}
  
enum DateFormatType {
  ///
  /// Returns a date formatter with a short date style format
  /// - Example date: "January 9, 1982 11:15 pm"
  ///
  case mediumDateFormat
}
