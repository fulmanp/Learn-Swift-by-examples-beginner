//
//  FieldText.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

class FieldText: Field {
  var fieldValue: String?
  
  override init(name: String, required: Bool = false) {
    super.init(name: name, required: required)
    type = .text()
  }
  
  override func set(_ string: String) -> Bool {
    fieldValue = string
    
    return true
  }
  
  override func toString() -> String {
    return fieldValue ?? ""
  }
}
