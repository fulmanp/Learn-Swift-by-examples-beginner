//
//  Field.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

enum FieldType {
  case
  undefined,
  email(name: String?=nil, required: Bool = false),
  note(name: String?=nil, required: Bool = false),
  text(name: String?=nil, required: Bool = false)
}

class Field {
  var name: String
  var required: Bool
  var type: FieldType
  
  init(name: String, required: Bool = false) {
    self.name = name
    self.required = required
    type = .undefined
  }
  
  func set(_ string: String) -> Bool {
    return true
  }
  
  func toString() -> String {
    return ""
  }
}
