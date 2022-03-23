//
//  tokenizer.swift
//  ch_05
//
//  Created by Piotr Fulmański on 16/03/2022.
//

import Foundation

enum TypeOfToken {
  case undefined
  case numberInteger, numberReal, identifier, action
  case openingBracket, closingBracket, space
  case separator
}

class Tokenizer {
  var formula = ""
  var singleCharTokens: [(character: Character, type: TypeOfCharacter, position: Int)] = []
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
  
  func getSingleCharTokens () -> Result {
    guard !formula.isEmpty else {return Result(ofType: .emptyString)}
    
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
      
      singleCharTokens.append((character: char, type: type, position: index))
      
      if type == .undefined {
        return Result(ofType: .undefinedCharacter(index))
      }
    }
    
    return Result(ofType: .ok)
  }
  
  func getTokens () -> Result {
    guard !singleCharTokens.isEmpty else {return Result(ofType: .noSingleCharTokens)}
    
    var tokensTmp: [(string: String, type: TypeOfToken, position: (from: Int, to: Int))] = []
    let charTokenNumber = singleCharTokens.count
    var index = 0
    var begin = 0, end = 0
    var type = TypeOfToken.undefined
    var string = ""
    
    while (index < charTokenNumber) {
      if singleCharTokens[index].type == .action {
        string = String(singleCharTokens[index].character)
        type = .action
        begin = singleCharTokens[index].position
        end = begin
        index += 1
      } else if singleCharTokens[index].type == .symbol {
        string = String(singleCharTokens[index].character)
        if singleCharTokens[index].character == "(" {
          type = .openingBracket
        } else if singleCharTokens[index].character == ")" {
          type = .closingBracket
        }
        begin = singleCharTokens[index].position
        end = begin
        index += 1
      } else if singleCharTokens[index].type == .separator {
        string = String(singleCharTokens[index].character)
        type = .separator
        begin = singleCharTokens[index].position
        end = begin
        index += 1
      } else if singleCharTokens[index].type == .space {
        string = String(singleCharTokens[index].character)
        type = .space
        begin = singleCharTokens[index].position
        end = begin
        index += 1
      } else if singleCharTokens[index].type == .digit {
        string = String(singleCharTokens[index].character)
        type = .numberInteger
        begin = singleCharTokens[index].position
        index += 1
        while index < charTokenNumber && singleCharTokens[index].type == .digit {
          string += String(singleCharTokens[index].character)
          index += 1
        }
        end = singleCharTokens[index-1].position
      } else if singleCharTokens[index].type == .letter {
        string = String(singleCharTokens[index].character)
        type = .identifier
        begin = singleCharTokens[index].position
        index += 1
        while index < charTokenNumber && singleCharTokens[index].type == .letter {
          string += String(singleCharTokens[index].character)
          index += 1
        }
        end = singleCharTokens[index-1].position
      }
      
      tokensTmp.append((string: string, type: type, position: (from: begin, to: end)))
    }
    
    // Remove unwanted spaces
    tokens.removeAll()
    var tokensCount = tokensTmp.count
    index = 0
    
    while (index < tokensCount) {
      tokens.append(tokensTmp[index])
      
      if tokensTmp[index].type == .space {
        // Consume all subsequent spaces
        while index < tokensCount && tokensTmp[index].type == .space {
          index += 1
        }
      } else {
        index += 1
      }
    }
    
    tokensTmp = tokens
    
    // Trim
    if tokensTmp[0].type == .space {
      tokensTmp.removeFirst()
    }
    
    if tokensTmp[tokensTmp.count-1].type == .space {
      tokensTmp.removeLast()
    }
    
    // Check presence of real numbers
    tokens.removeAll()
    
    tokensCount = tokensTmp.count
    index = 0
    
    while (index < tokensCount) {
      if ![TypeOfToken.numberInteger, TypeOfToken.separator].contains(tokensTmp[index].type) {
        tokens.append(tokensTmp[index])
        index += 1
      } else {
        if tokensTmp[index].type == .numberInteger {
          if index+1 < tokensCount {
            if tokensTmp[index+1].type == .separator {
              // There is a separator, so there may be also a fractional part
              if index+2 < tokensCount {
                if tokensTmp[index+2].type == .numberInteger {
                  // There is a fractional part
                  string = tokensTmp[index].string + "." + tokensTmp[index+2].string
                  type = .numberReal
                  begin = tokensTmp[index].position.from
                  end = tokensTmp[index+2].position.to
                  tokens.append((string: string,
                                 type: type,
                                 position: (from: begin, to: end))
                  )
                  index += 3
                } else if tokensTmp[index+2].type == .separator {
                  // Incorrect format - two separators one after another
                  return Result(ofType: .unexpectedToken(tokensTmp[index+2].position.from))
                } else { // There is no fractional part, so it must be 0.
                  string = tokensTmp[index].string + ".0"
                  type = .numberReal
                  begin = tokensTmp[index].position.from
                  end = tokensTmp[index+1].position.to
                  tokens.append((string: string,
                                 type: type,
                                 position: (from: begin, to: end))
                  )
                  index += 2
                }
              } else {
                // If not, this is a real number with a fractional part
                // equal to 0.
                string = tokensTmp[index].string + ".0"
                type = .numberReal
                begin = tokensTmp[index].position.from
                end = tokensTmp[index+1].position.to
                tokens.append((string: string,
                               type: type,
                               position: (from: begin, to: end))
                )
                index += 2
              }
            } else {
              // No separator after integer part,
              // so this must be an integer
              tokens.append(tokensTmp[index])
              index += 1
            }
          } else { // No more tokens, so this is an integer
            tokens.append(tokensTmp[index])
            index += 1
          }
        } else if tokensTmp[index].type == .separator {
          if index+1 < tokensCount {
            if tokensTmp[index+1].type == .numberInteger {
              string = "0." + tokensTmp[index+1].string
              type = .numberReal
              begin = tokensTmp[index].position.from
              end = tokensTmp[index+1].position.to
              tokens.append((string: string,
                             type: type,
                             position: (from: begin, to: end))
              )
              index += 2
            } else {
              // For example ".a"
              return Result(ofType: .unexpectedToken(tokensTmp[index+1].position.from))
            }
          } else {
            // For example "."
            return Result(ofType: .missingToken(tokensTmp[index].position.to))
          }
        }
      }
    }
    
    return Result(ofType: .ok)
  }
}
