//
//  constants.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

enum ProcessingResultType {
  case
  undefined,
  ok,
  emptyString,
  noSingleCharTokens,
  undefinedCharacter (Int), // at position
  undefinedToken (Int), // starting at position
  unexpectedToken (Int), // starting at position
  missingToken (Int) // after position
}

// Extension is here to prevent message
// Extension outside of file declaring enum 'ProcessingResultType'
// prevents automatic synthesis of '==' for protocol 'Equatable'
extension ProcessingResultType: Equatable {
  
}

class ProcessingResult {
  var msg: String?
  var resultType = ProcessingResultType.undefined
  
  init(ofType resultType: ProcessingResultType, withMessage msg: String? = nil) {
    self.resultType = resultType
    self.msg = msg
  }
}

