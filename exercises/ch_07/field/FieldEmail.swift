//
//  FieldEmail.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

class FieldEmail: Field {
  var fieldValue: String?
  
  override init(name: String, required: Bool = false) {
    super.init(name: name, required: required)
    type = .email()
  }
  
  override func set(_ string: String) -> Bool {
    if validate(string: string) {
      fieldValue = string
      return true
    }
    
    return false
  }
  
  private func validate(string: String) -> Bool {
    // Validate if string is a correct email
    return true
  }
  
  override func toString() -> String {
    return fieldValue ?? ""
  }
}
