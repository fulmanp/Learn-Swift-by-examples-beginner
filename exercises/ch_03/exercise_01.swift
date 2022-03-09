//
//  exercise_01.swift
//  exercise_03_01
//
//  Created by Piotr Fulmański on 02/03/2022.
//

import Foundation

func exercise_01() {

enum FilterResult {
  case accept, reject
}

func criterium(element: Int) -> FilterResult {
  if element % 3 == 0 {
    return .accept
  } else {
    return .reject
  }
}

func visualise(element: FilterResult) -> String {
  switch element {
  case .accept:
    return "+"
  case .reject:
    return "."
  }
}

let min = 2
let max = 10

var sourceArray = [Int]()
var resultArray = [FilterResult]()
var s = ""

for index in min...max {
  sourceArray.append(index)
}

for element in sourceArray {
  resultArray.append(criterium(element: element))
}

for result in resultArray {
  s += visualise(element: result)
}

print(s)

}
