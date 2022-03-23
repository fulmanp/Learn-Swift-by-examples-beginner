//
//  constants.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

enum ResultType {
  case
  unknown,
  ok,
  emptyString,
  noSingleCharTokens,
  undefinedCharacter (Int), // at position
  unexpectedToken (Int), // starting at position
  missingToken (Int) // after position
}

class Result {
  var msg: String?
  var resultType = ResultType.unknown
  
  init(ofType resultType: ResultType, withMessage msg: String? = nil) {
    self.resultType = resultType
    self.msg = msg
  }
}

