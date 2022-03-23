//
//  main.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

let formula = "  123.6 +  (..13*.5 - 20.34) /4. + val  "

//let formula = "." // Missing token after position 0
//let formula = ".a" // Unexpected token at position 1
//let formula = "12.a" // Unexpected token at position 3
//let formula = ".98"
//let formula = "123.6 +(.13*.5 - 20.34) /4. + val"

print(formula.toCharacters())

let tokenizer = Tokenizer()

tokenizer.set(formula: formula)
var result = tokenizer.getSingleCharTokens()

if case .ok = result.resultType {
  for token in tokenizer.singleCharTokens {
    print(token)
  }
  
  result = tokenizer.getTokens()
  
  if case .ok = result.resultType {
    print("---------------")
    for token in tokenizer.tokens {
      print(token)
    }
  } else if case .missingToken(let position) = result.resultType {
    print("Missing token after position \(position)")
    print(tokenizer.singleCharTokens[position])
  } else if case .unexpectedToken(let position) = result.resultType {
    print("Unexpected token at position \(position)")
    print(tokenizer.singleCharTokens[position])
  } else {
    print(result.resultType)
  }
} else {
  print(result.resultType)
  if case .undefinedCharacter(let position) = result.resultType {
    let char = tokenizer.singleCharTokens.last?.character ?? "-"
    print("Undefined character \(char) at position \(position)")
  }
}


