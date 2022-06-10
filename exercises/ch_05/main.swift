//
//  main.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

func main(formula: String) {
  print(formula.toCharacters())

  let tokenizer = Tokenizer()

  tokenizer.set(formula: formula)
  let result = tokenizer.getTokens()

  print("=== singleCharTokens:")
  for token in tokenizer.singleCharTokens {
    print(token)
  }
  
  print("=== multipleCharTokens:")
  for token in tokenizer.multipleCharTokens {
    print(token)
  }
  
  print("=== tokens:")
  for token in tokenizer.tokens {
    print(token)
  }
  
  print("=== Result:")
  switch result.resultType {
  case .ok:
    for token in tokenizer.tokens {
      print(token)
    }
  case .emptyString:
    print("main: Empty string")
  case .undefined:
    print("main: Undefined problems")
  case .noSingleCharTokens:
    print("main: Internal problems. No single char tokens")
  case .undefinedCharacter(let position):
    print("main: Unexpected character at position \(position)")
    print(tokenizer.singleCharTokens[position])
  case .undefinedToken(let position):
    print("main: Undefined token at position \(position)")
    print(tokenizer.multipleCharTokens[position])
  case .unexpectedToken(let position):
    print("main: Unexpected token at position \(position)")
    print(tokenizer.multipleCharTokens[position])
  case .missingToken(let position):
    print("main: Missing token after position \(position)")
    print(tokenizer.multipleCharTokens[position])
  }
}

//let formula = "."
/*
 ["."]
 === singleCharTokens:
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 0)
 === multipleCharTokens:
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 0, to: 0))
 === tokens:
 === Result:
 main: Undefined token at position 0
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 0, to: 0))
 Program ended with exit code: 0
 */

//let formula = ".a"
/*
 [".", "a"]
 === singleCharTokens:
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 0)
 (character: "a", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 1)
 === multipleCharTokens:
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 0, to: 0))
 (string: "a", type: ch_05.TypeOfToken.identifier, position: (from: 1, to: 1))
 === tokens:
 === Result:
 main: Unexpected token at position 1
 (string: "a", type: ch_05.TypeOfToken.identifier, position: (from: 1, to: 1))
 Program ended with exit code: 0
 */

//let formula = "12.a"
// !!! This should be filter out in next processing step.
// At this level it is correct but generally identifier should not follow
// directly real number
/*
 ["1", "2", ".", "a"]
 === singleCharTokens:
 (character: "1", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 0)
 (character: "2", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 1)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 2)
 (character: "a", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 3)
 === multipleCharTokens:
 (string: "12", type: ch_05.TypeOfToken.numberInteger, position: (from: 0, to: 1))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 2, to: 2))
 (string: "a", type: ch_05.TypeOfToken.identifier, position: (from: 3, to: 3))
 === tokens:
 (string: "12.", type: ch_05.TypeOfToken.numberReal, position: (from: 0, to: 2))
 (string: "a", type: ch_05.TypeOfToken.identifier, position: (from: 3, to: 3))
 === Result:
 (string: "12.", type: ch_05.TypeOfToken.numberReal, position: (from: 0, to: 2))
 (string: "a", type: ch_05.TypeOfToken.identifier, position: (from: 3, to: 3))
 Program ended with exit code: 0
 */

//let formula = ".98"
/*
 [".", "9", "8"]
 === singleCharTokens:
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 0)
 (character: "9", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 1)
 (character: "8", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 2)
 === multipleCharTokens:
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 0, to: 0))
 (string: "98", type: ch_05.TypeOfToken.numberInteger, position: (from: 1, to: 2))
 === tokens:
 (string: ".98", type: ch_05.TypeOfToken.numberReal, position: (from: 0, to: 2))
 === Result:
 (string: ".98", type: ch_05.TypeOfToken.numberReal, position: (from: 0, to: 2))
 */


//let formula = "  123.6 +  (..13*.5 - 20.34) /4. + val  "
/*
 [" ", " ", "1", "2", "3", ".", "6", " ", "+", " ", " ", "(", ".", ".", "1", "3", "*", ".", "5", " ", "-", " ", "2", "0", ".", "3", "4", ")", " ", "/", "4", ".", " ", "+", " ", "v", "a", "l", " ", " "]
 === singleCharTokens:
 (character: "1", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 2)
 (character: "2", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 3)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 4)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 5)
 (character: "6", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 6)
 (character: "+", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 8)
 (character: "(", type: ch_05.Tokenizer.TypeOfCharacter.symbol, position: 11)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 12)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 13)
 (character: "1", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 14)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 15)
 (character: "*", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 16)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 17)
 (character: "5", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 18)
 (character: "-", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 20)
 (character: "2", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 22)
 (character: "0", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 23)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 24)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 25)
 (character: "4", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 26)
 (character: ")", type: ch_05.Tokenizer.TypeOfCharacter.symbol, position: 27)
 (character: "/", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 29)
 (character: "4", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 30)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 31)
 (character: "+", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 33)
 (character: "v", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 35)
 (character: "a", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 36)
 (character: "l", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 37)
 === multipleCharTokens:
 (string: "123", type: ch_05.TypeOfToken.numberInteger, position: (from: 2, to: 4))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 5, to: 5))
 (string: "6", type: ch_05.TypeOfToken.numberInteger, position: (from: 6, to: 6))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 8, to: 8))
 (string: "(", type: ch_05.TypeOfToken.openingBracket, position: (from: 11, to: 11))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 12, to: 12))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 13, to: 13))
 (string: "13", type: ch_05.TypeOfToken.numberInteger, position: (from: 14, to: 15))
 (string: "*", type: ch_05.TypeOfToken.action, position: (from: 16, to: 16))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 17, to: 17))
 (string: "5", type: ch_05.TypeOfToken.numberInteger, position: (from: 18, to: 18))
 (string: "-", type: ch_05.TypeOfToken.action, position: (from: 20, to: 20))
 (string: "20", type: ch_05.TypeOfToken.numberInteger, position: (from: 22, to: 23))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 24, to: 24))
 (string: "34", type: ch_05.TypeOfToken.numberInteger, position: (from: 25, to: 26))
 (string: ")", type: ch_05.TypeOfToken.closingBracket, position: (from: 27, to: 27))
 (string: "/", type: ch_05.TypeOfToken.action, position: (from: 29, to: 29))
 (string: "4", type: ch_05.TypeOfToken.numberInteger, position: (from: 30, to: 30))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 31, to: 31))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 33, to: 33))
 (string: "val", type: ch_05.TypeOfToken.identifier, position: (from: 35, to: 37))
 === tokens:
 === Result:
 main: Unexpected token at position 6
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 13, to: 13))
*/

let formula = "  123.6 +  (.13*.5 - 20.34) /4. + val  "
/*
 [" ", " ", "1", "2", "3", ".", "6", " ", "+", " ", " ", "(", ".", "1", "3", "*", ".", "5", " ", "-", " ", "2", "0", ".", "3", "4", ")", " ", "/", "4", ".", " ", "+", " ", "v", "a", "l", " ", " "]
 === singleCharTokens:
 (character: "1", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 2)
 (character: "2", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 3)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 4)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 5)
 (character: "6", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 6)
 (character: "+", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 8)
 (character: "(", type: ch_05.Tokenizer.TypeOfCharacter.symbol, position: 11)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 12)
 (character: "1", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 13)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 14)
 (character: "*", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 15)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 16)
 (character: "5", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 17)
 (character: "-", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 19)
 (character: "2", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 21)
 (character: "0", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 22)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 23)
 (character: "3", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 24)
 (character: "4", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 25)
 (character: ")", type: ch_05.Tokenizer.TypeOfCharacter.symbol, position: 26)
 (character: "/", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 28)
 (character: "4", type: ch_05.Tokenizer.TypeOfCharacter.digit, position: 29)
 (character: ".", type: ch_05.Tokenizer.TypeOfCharacter.separator, position: 30)
 (character: "+", type: ch_05.Tokenizer.TypeOfCharacter.action, position: 32)
 (character: "v", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 34)
 (character: "a", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 35)
 (character: "l", type: ch_05.Tokenizer.TypeOfCharacter.letter, position: 36)
 === multipleCharTokens:
 (string: "123", type: ch_05.TypeOfToken.numberInteger, position: (from: 2, to: 4))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 5, to: 5))
 (string: "6", type: ch_05.TypeOfToken.numberInteger, position: (from: 6, to: 6))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 8, to: 8))
 (string: "(", type: ch_05.TypeOfToken.openingBracket, position: (from: 11, to: 11))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 12, to: 12))
 (string: "13", type: ch_05.TypeOfToken.numberInteger, position: (from: 13, to: 14))
 (string: "*", type: ch_05.TypeOfToken.action, position: (from: 15, to: 15))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 16, to: 16))
 (string: "5", type: ch_05.TypeOfToken.numberInteger, position: (from: 17, to: 17))
 (string: "-", type: ch_05.TypeOfToken.action, position: (from: 19, to: 19))
 (string: "20", type: ch_05.TypeOfToken.numberInteger, position: (from: 21, to: 22))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 23, to: 23))
 (string: "34", type: ch_05.TypeOfToken.numberInteger, position: (from: 24, to: 25))
 (string: ")", type: ch_05.TypeOfToken.closingBracket, position: (from: 26, to: 26))
 (string: "/", type: ch_05.TypeOfToken.action, position: (from: 28, to: 28))
 (string: "4", type: ch_05.TypeOfToken.numberInteger, position: (from: 29, to: 29))
 (string: ".", type: ch_05.TypeOfToken.separator, position: (from: 30, to: 30))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 32, to: 32))
 (string: "val", type: ch_05.TypeOfToken.identifier, position: (from: 34, to: 36))
 === tokens:
 (string: "123.6", type: ch_05.TypeOfToken.numberReal, position: (from: 2, to: 6))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 8, to: 8))
 (string: "(", type: ch_05.TypeOfToken.openingBracket, position: (from: 11, to: 11))
 (string: ".13", type: ch_05.TypeOfToken.numberReal, position: (from: 12, to: 14))
 (string: "*", type: ch_05.TypeOfToken.action, position: (from: 15, to: 15))
 (string: ".5", type: ch_05.TypeOfToken.numberReal, position: (from: 16, to: 17))
 (string: "-", type: ch_05.TypeOfToken.action, position: (from: 19, to: 19))
 (string: "20.34", type: ch_05.TypeOfToken.numberReal, position: (from: 21, to: 25))
 (string: ")", type: ch_05.TypeOfToken.closingBracket, position: (from: 26, to: 26))
 (string: "/", type: ch_05.TypeOfToken.action, position: (from: 28, to: 28))
 (string: "4.", type: ch_05.TypeOfToken.numberReal, position: (from: 29, to: 30))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 32, to: 32))
 (string: "val", type: ch_05.TypeOfToken.identifier, position: (from: 34, to: 36))
 === Result:
 (string: "123.6", type: ch_05.TypeOfToken.numberReal, position: (from: 2, to: 6))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 8, to: 8))
 (string: "(", type: ch_05.TypeOfToken.openingBracket, position: (from: 11, to: 11))
 (string: ".13", type: ch_05.TypeOfToken.numberReal, position: (from: 12, to: 14))
 (string: "*", type: ch_05.TypeOfToken.action, position: (from: 15, to: 15))
 (string: ".5", type: ch_05.TypeOfToken.numberReal, position: (from: 16, to: 17))
 (string: "-", type: ch_05.TypeOfToken.action, position: (from: 19, to: 19))
 (string: "20.34", type: ch_05.TypeOfToken.numberReal, position: (from: 21, to: 25))
 (string: ")", type: ch_05.TypeOfToken.closingBracket, position: (from: 26, to: 26))
 (string: "/", type: ch_05.TypeOfToken.action, position: (from: 28, to: 28))
 (string: "4.", type: ch_05.TypeOfToken.numberReal, position: (from: 29, to: 30))
 (string: "+", type: ch_05.TypeOfToken.action, position: (from: 32, to: 32))
 (string: "val", type: ch_05.TypeOfToken.identifier, position: (from: 34, to: 36))
 Program ended with exit code: 0
 */

main(formula: formula)
