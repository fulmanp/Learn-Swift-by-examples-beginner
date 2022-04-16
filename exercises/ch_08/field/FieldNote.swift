//
//  FieldNote.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

class FieldNote: Field {
  var fieldValue: String?
  
  override init(name: String, required: Bool = false) {
    super.init(name: name, required: required)
    type = .note()
  }
  
  override func set(_ string: String) -> Bool {
    fieldValue = string
    
    return true
  }
  
  override func toString() -> String {
    return fieldValue ?? ""
  }
}
