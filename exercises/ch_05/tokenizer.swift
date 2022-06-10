//
//  tokenizer.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

enum TypeOfToken {
  case undefined, unexpected
  case numberInteger, numberReal, identifier, action
  case openingBracket, closingBracket, space
  case separator
}

class Tokenizer {
  var formula = ""
  var singleCharTokens: [(character: Character, type: TypeOfCharacter, position: Int)] = []
  var multipleCharTokens: [(string: String, type: TypeOfToken, position: (from: Int, to: Int))] = []
  var tokens: [(string: String, type: TypeOfToken, position: (from: Int, to: Int))] = []
  
  enum TypeOfCharacter {
    // Because keyword 'operator' cannot be used as an identifier
    // I use 'action'
    case undefined, digit, letter, action, symbol, separator, space
  }
  
  init() {
    
  }
  
  func set(formula: String) {
    self.formula = formula
  }
  
  
  func getSingleCharTokens () -> ProcessingResult {
    guard !formula.isEmpty else {return ProcessingResult(ofType: .emptyString)}
    
    let characters = formula.toCharacters()
    singleCharTokens.removeAll()
    
    var type = TypeOfCharacter.undefined
    
    for (index, char) in characters.enumerated() {
      if char.isNumber {
        type = .digit
      } else if char.isLetter {
        type = .letter
      } else if char.isWhitespace {
        type = .space
      } else {
        switch char {
        case ".":
          type = .separator
        case "(", ")":
          type = .symbol
        case "*", "+", "-", "/":
          type = .action
        default:
          type = .undefined
        }
      }
      
      // Remove all spaces, as I don't need them
      if type != .space {
        singleCharTokens.append((character: char, type: type, position: index))
      }
      
      if type == .undefined {
        return ProcessingResult(ofType: .undefinedCharacter(index))
      }
    }
    
    return ProcessingResult(ofType: .ok)
  }
  
  
  func getMultipleCharTokens () -> ProcessingResult {
    guard !singleCharTokens.isEmpty else {return ProcessingResult(ofType: .noSingleCharTokens)}
    
    let charTokenNumber = singleCharTokens.count
    var index = 0
    var begin = 0, end = 0
    var type = TypeOfToken.undefined
    var string = ""
    
    while (index < charTokenNumber) {
      let typeAux = singleCharTokens[index].type
      let char = singleCharTokens[index].character
      let position = singleCharTokens[index].position
      
      switch typeAux {
      case .action:
        string = String(char)
        type = .action
        begin = position
        end = begin
        index += 1
      case .symbol:
        string = String(char)
        if singleCharTokens[index].character == "(" {
          type = .openingBracket
        } else if singleCharTokens[index].character == ")" {
          type = .closingBracket
        }
        begin = position
        end = begin
        index += 1
      case .separator:
        string = String(char)
        type = .separator
        begin = position
        end = begin
        index += 1
      case .digit:
        string = String(char)
        type = .numberInteger
        begin = position
        index += 1
        while index < charTokenNumber && singleCharTokens[index].type == .digit {
          string += String(singleCharTokens[index].character)
          index += 1
        }
        end = singleCharTokens[index-1].position
      case .letter:
        string = String(char)
        type = .identifier
        begin = position
        index += 1
        while index < charTokenNumber && singleCharTokens[index].type == .letter {
          string += String(singleCharTokens[index].character)
          index += 1
        }
        end = singleCharTokens[index-1].position
      case .space:
        // There should be no spaces here as I removed all of them
        // in previous step: getSingleCharTokens () -> Result
        return ProcessingResult(ofType: .undefinedCharacter(position))
      case .undefined:
        return ProcessingResult(ofType: .undefinedCharacter(position))
      }
      
      multipleCharTokens.append((string: string, type: type, position: (from: begin, to: end)))
    }
      
    return ProcessingResult(ofType: .ok)
  }
  
  
  func parseNumber(fromIndex begin: Int) -> (type: TypeOfToken, tokenPosition: Int, string: String, begin: Int, end: Int, sizeInTokens: Int) {
    let tokensCount = multipleCharTokens.count
    let string = multipleCharTokens[begin].string
    
    // Must be real or invalid number
    if multipleCharTokens[begin].type == .separator {
      // Separator is the last character in sequence
      if begin == tokensCount-1 {
        return (type: TypeOfToken.undefined,
                tokenPosition: begin,
                string: string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin].position.to,
                sizeInTokens: 1
        )
      }
            
      // Separator is not the last separator in the sequence,
      // so it's safe to use begin+1 index.
      if multipleCharTokens[begin+1].type == .numberInteger {
        return (type: TypeOfToken.numberReal,
                tokenPosition: begin,
                string: string + multipleCharTokens[begin+1].string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin+1].position.to,
                sizeInTokens: 2
        )
      }
      
      // numberInteger must follow separator. Other case means error
      return (type: TypeOfToken.unexpected,
              tokenPosition: begin+1,
              string: multipleCharTokens[begin+1].string,
              begin: multipleCharTokens[begin+1].position.from,
              end: multipleCharTokens[begin+1].position.to,
              sizeInTokens: 1
      )
    } // May be integer or real
    else if multipleCharTokens[begin].type == .numberInteger {
      // numberInteger is the last token in sequence
      if begin == tokensCount-1 {
        return (type: TypeOfToken.numberInteger,
                tokenPosition: begin,
                string: string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin].position.to,
                sizeInTokens: 1
        )
      }
      
      // There must be at least one token following integer
      // May be a pure integer: 123[SOMETHING]
      if multipleCharTokens[begin+1].type != .separator {
        return (type: TypeOfToken.numberInteger,
                tokenPosition: begin,
                string: multipleCharTokens[begin].string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin].position.to,
                sizeInTokens: 1
        )
      }
      
      // May be a pure integer with separator: 123. and no more other tokens
      if multipleCharTokens[begin+1].type == .separator
          && begin+1 == tokensCount-1 {
        return (type: TypeOfToken.numberReal,
                tokenPosition: begin,
                string: multipleCharTokens[begin].string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin+1].position.to,
                sizeInTokens: 2
        )
      }
      
      // There are at least 2 tokens following integer
      // It can be of the form: 123.[SOMETHING]
      if multipleCharTokens[begin+1].type == .separator
          && multipleCharTokens[begin+2].type != .numberInteger {
        return (type: TypeOfToken.numberReal,
                tokenPosition: begin,
                string: string + multipleCharTokens[begin+1].string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin+1].position.to,
                sizeInTokens: 2
        )
      }
      
      // It can be of the form 123.456
      if multipleCharTokens[begin+1].type == .separator
          && multipleCharTokens[begin+2].type == .numberInteger {
        return (type: TypeOfToken.numberReal,
                tokenPosition: begin+1,
                string: string
                + multipleCharTokens[begin+1].string
                + multipleCharTokens[begin+2].string,
                begin: multipleCharTokens[begin].position.from,
                end: multipleCharTokens[begin+2].position.to,
                sizeInTokens: 3
        )
      }
    }
    
    // Shouldn't be ever returned
    return (type: TypeOfToken.undefined,
            tokenPosition: begin,
            string: string,
            begin: multipleCharTokens[begin].position.from,
            end: multipleCharTokens[begin].position.to,
            sizeInTokens: 1
    )
  }
  
  func identifyRealNumbers() -> ProcessingResult {
    // Check presence of one separator just after another
    let tokensCount = multipleCharTokens.count
    
    if tokensCount>1 {
      for index in 0...tokensCount-2 {
        if multipleCharTokens[index].type == .separator
            && multipleCharTokens[index+1].type == .separator {
          return ProcessingResult(ofType: .unexpectedToken(index+1))
        }
      }
    }
    
    // 
    var index = 0
    while (index < tokensCount) {
      let type = multipleCharTokens[index].type
      
      switch type {
      case .action, .identifier, .closingBracket, .openingBracket:
        tokens.append(multipleCharTokens[index])
        index += 1
      case .numberInteger, .separator:
        let result = parseNumber(fromIndex: index)
        
        if result.type == .unexpected {
          return ProcessingResult(ofType: .unexpectedToken(result.tokenPosition))
        } else if result.type == .undefined {
          return ProcessingResult(ofType: .undefinedToken(result.tokenPosition))
        } else {
          tokens.append((string: result.string,
                         type: result.type,
                         position: (from: result.begin, to: result.end)))
        }
        index += result.sizeInTokens
      //case .numberReal:
        // This type of token will be added in this while loop
      //case .undefined, .space:
        // There should be no undefined and space tokens at this level
      default:
        return ProcessingResult(ofType: .unexpectedToken(index))
      }
    }
    
    return ProcessingResult(ofType: .ok)
  }
  
  
  
  func getTokens() -> ProcessingResult {
    tokens.removeAll()
    var result = getSingleCharTokens()
    if result.resultType != .ok {
      return result
    }
    result = getMultipleCharTokens()
    if result.resultType != .ok {
      return result
    }
    result = identifyRealNumbers()
    if result.resultType != .ok {
      return result
    }
    return ProcessingResult(ofType: .ok)
  }
}
