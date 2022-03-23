//
//  validators.swift
//  ch_04
//
//  Created by Piotr Fulmański on 09/03/2022.
//

import Foundation

/*
 This solution attempts to mimic the abstract class pattern.
 Abstract classes aren't supported in Swift and this solution
 is nothing more than an attempt to patch the absence of abstract
 classes in Swift.
 
 You will see other options how this could be implemented in a future.
 */

class DataValidator {
  var data: String = ""
  
  init() {
    
  }
  
  init(data: String) {
    self.data = data
  }
  
  func setStringToValidate(_ data: String) {
    self.data = data
  }
  
  func validate() -> Bool {
    return true
  }
}

class ValidatorIntegerInRange: DataValidator {
  var minValue = 0
  var maxValue = 0
  
  func set(min: Int, max: Int) {
    minValue = min
    maxValue = max
  }
  
  override func validate() -> Bool {
    if let value = Int(data) {
      if (value >= minValue && value <= maxValue) {
        return true
      } else {
        return false
      }
    }
    
    return false
  }
}

class ValidatorBoolean: DataValidator {
  override func validate() -> Bool {
    if ["T", "F", "t", "f"].contains(data) {
      return true
    }
    
    return false
  }
}

class Validator3StateLogic: DataValidator {
  override func validate() -> Bool {
    if ["Y", "N", "U", "y", "n", "u"].contains(data) {
      return true
    }
    
    return false
  }
}

class ValidatorPossibleValues: DataValidator {
  var setOfPossibleValues: [String] = []
  
  func defineSetOfPossibleValues(set: [String]) {
    setOfPossibleValues = set
  }

  override func validate() -> Bool {
    if setOfPossibleValues.contains(data) {
      return true
    }
    
    return false
  }
}

