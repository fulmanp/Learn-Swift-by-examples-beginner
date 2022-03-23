//
//  tag.swift
//  ch_06
//
//  Created by Piotr Fulmański on 23/03/2022.
//

import Foundation

class Tag: Codable {
  let uuid: UUID
  var shortName: String
  var longName: String?
  var description: String?
  
  convenience init(shortName: String, longName: String? = nil, description: String? = nil) {
    self.init(uuid: UUID(), shortName: shortName, longName: longName, description: description)
  }
  
  init(uuid: UUID, shortName: String, longName: String?, description: String?) {
    self.uuid = uuid
    self.shortName = shortName
    self.longName = longName
    self.description = description
  }
  
  func describe() -> (uuid: String,
                      shortName: String,
                      longName: String,
                      description: String) {
    return (
      uuid: uuid.uuidString,
      shortName: shortName,
      longName: longName != nil ? longName! : "undefined",
      description: longName != nil ? description! : "undefined"
    )
  }
}
