//
//  exercise_04.swift
//  exercise_03
//
//  Created by Piotr Fulmański on 02/03/2022.
//

import Foundation

func exercise_04() {
 
// Data mapping:
// integer: [0-50)  = 1,0,0,0
//          [50-70) = 0,1,0,0
//          [70-90) = 0,0,1,0
//          [90...) = 0,0,0,1
// [A|B|C]: A = 1,0,0
//          B = 0,1,0
//          C = 0,0,1
// real:    do nothing, leave the value as is
// boolean: T = 1
//          F = 0
// 3-state: Y = 1,0,0
//          N = 0,1,0
//          S = 0,0,1
  
let data = [
  //integer (age),[A|B|C],real,boolean,3-state
  "75,B,1.56,T,S", // 0,0,1,0,0,1,0,1.56,1,0,0,1
  "40,C,1.20,F,Y", // 1,0,0,0,0,0,1,1.20,0,1,0,0
]
  

func coderAge(data: String) -> String {
  if let v = Int(data) {
    if v<50 {
      return "1,0,0,0"
    } else if v<70 {
      return "0,1,0,0"
    } else if v<90 {
      return "0,0,1,0"
    } else if v >= 90 {
      return "0,0,0,1"
    }
  }
  
  return "!,!,!,!"
}
  
func coderClass(data: String) -> String {
  switch data {
  case "A":
    return "1,0,0"
  case "B":
    return "0,1,0"
  case "C":
    return "0,0,1"
  default:
    return "!,!,!"
  }
}
  
func coderBoolean(data: String) -> String {
  switch data {
  case "T":
    return "1"
  case "F":
    return "0"
  default:
    return "!"
  }
}
  
func coder3State(data: String) -> String {
  switch data {
  case "Y":
    return "1,0,0"
  case "N":
    return "0,1,0"
  case "S":
    return "0,0,1"
  default:
    return "!,!,!"
  }
}
  
func coderDummy(data: String) -> String {
  return data
}

let coders = [
  coderAge,
  coderClass,
  coderDummy,
  coderBoolean,
  coder3State
]
  
for d in data {
  let record = d.components(separatedBy: ",")
  for (index, value) in record.enumerated() {
    let coder = coders[index]
    let codedValue = coder(value)
    print("\(value) -> \(codedValue)")
  }
}

  /*
   if i<min(rowDataCount, __maxColNumber)-1:
         if i in coders and not coders[i] == coderRemove:
           #print(";", end="")
           line += ";"
         elif i not in coders:
           #print(";", end="")
           line += ";"
   */
}
