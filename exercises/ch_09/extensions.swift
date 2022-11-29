//
//  extensions.swift
//  ch_09
//
//  Created by Piotr Fulmański on 22/04/2022.
//

import Foundation

extension Pump: UniquelyIdentifiable, Namable, Stringable {
  func getID() -> String {
    return "pump_\(serialNumber)"
  }

  func getName() -> String {
    let thisType = type(of: self)
    return String(describing: thisType)
  }

  func getString() -> String {
    
    struct MyData: Encodable {
      var uniqueObjectID: String
      var className: String
      var values: [[String]]
    }
    
    var values = [[String]]()
    values.append(["serialNumber", "String", serialNumber])
    values.append(["capacity", "Int", capacity != nil ? "\(capacity!)" : "NULL"])
    values.append(["weight", "Int", weight != nil ? "\(weight!)" : "NULL"])
    
    let data = MyData(
      uniqueObjectID: getID(),
      className: getName(),
      values: values
    )
    
    let encoder = JSONEncoder()
    if let jsonData = try? encoder.encode(data) {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    }
    
    return ""
  }
}


extension Device: UniquelyIdentifiable, Namable, Stringable {
  func getID() -> String {
    let identifierComponents = identifier.capturedGroups(
      withRegex: #"(?<type>.+?)_(?<year>\d{4})_(?<serialNumber>.+)"#,
      groupNames: ["type", "serialNumber"]
    )

    let type = identifierComponents["type"] ?? "NULL"
    let serial = identifierComponents["serialNumber"] ?? "NULL"
    
    return type + "_" + serial
  }

  func getName() -> String {
    let thisType = type(of: self)
    return String(describing: thisType)
  }

  func getString() -> String {
    
    struct MyData: Encodable {
      var uniqueObjectID: String
      var className: String
      var values: [[String]]
    }
    
    var values = [[String]]()
    values.append(["identifier", "String", identifier])
    values.append(["deviceType", "DeviceType", String(describing: deviceType.rawValue)])
    values.append(["weight", "Int", weight != nil ? "\(weight!)" : "NULL"])
    
    let data = MyData(
      uniqueObjectID: getID(),
      className: getName(),
      values: values
    )
    
    let encoder = JSONEncoder()
    if let jsonData = try? encoder.encode(data) {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    }
    
    return ""
  }
}

extension String {
  /**
   String extension that extract the captured groups with a regex pattern
   - parameter pattern: regex pattern
   - parameter groupNames: names of groups
   - Returns: captured groups
  */
  public func capturedGroups(
    withRegex pattern: String,
    groupNames: [String]
  ) -> [String:String] {
    var result: [String:String] = [:]
    
    let stringRange = NSRange(
        self.startIndex..<self.endIndex,
        in: self
    )
    
    let regexp: NSRegularExpression
    
    do {
      regexp = try NSRegularExpression(pattern: pattern, options: [])
    } catch {
      return result
    }
    
    // Find the matching capture groups
    let matches = regexp.matches(
        in: self,
        options: [],
        range: stringRange
    )
    
    guard let match = matches.first else {return result}

    // For each matched range, extract the named capture group
    for name in groupNames {
      let matchRange = match.range(withName: name)
      
      // Extract the substring matching the named capture group
      if let substringRange = Range(matchRange, in: self) {
          let capture = String(self[substringRange])
          result[name] = capture
      }
    }
    
    return result
    
    /* Other implementation
    let lastRangeIndex = match.numberOfRanges - 1
      guard lastRangeIndex >= 1 else { return result }
      
      for i in 1...lastRangeIndex {
        let capturedGroupIndex = match.range(at: i)
        let matchedString = (self as NSString).substring(with: capturedGroupIndex)
        result.append(matchedString)
      }
    }
    */
  }
}
