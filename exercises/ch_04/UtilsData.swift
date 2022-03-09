//
//  UtilsData.swift
//  ch_04
//
//  Created by Piotr Fulmański on 09/03/2022.
//

import Foundation

class ResultSplit {
  var data: [String]
  var count: Int
  
  init(_ data: [String]) {
    self.data = data
    count =  data.count
  }
}

class UtilsData {
  class func split(row: String, bySeparator separator: String, trim: Bool = true) -> ResultSplit {
    var splitedRow = row.components(separatedBy: separator)
    // Other options to filter data
    //text.split(separator: " ")
    //text.components(separatedBy: [",", " ", "!",".","?"]).filter({!$0.isEmpty})
    
    if trim {
      for i in 0...splitedRow.count-1 {
        splitedRow[i] = splitedRow[i].trimmingCharacters(in: .whitespacesAndNewlines)
      }
    }
    
    return ResultSplit(splitedRow)
  }
  
  class func validate(data: [String], validators: [DataValidator]) -> [Bool]? {
    guard data.count == validators.count
    else {
      return nil
    }
    
    var resultValidation = [Bool]()
    
    for i in 0...data.count-1 {
      validators[i].setStringToValidate(data[i])
      let result = validators[i].validate()
      resultValidation.append(result)
    }
    
    return resultValidation
  }
}
