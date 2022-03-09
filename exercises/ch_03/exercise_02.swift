//
//  exercise_02.swift
//  exercise_03
//
//  Created by Piotr Fulmański on 02/03/2022.
//

import Foundation

//
// Sieve of Eratosthenes
// https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
//
func exercise_02() {

enum IsPrime {
  case prime(Int), nonPrime(Int)
}

let min = 10
let max = 20

var testArray = [IsPrime]()
  
for value in min...max {
  testArray.append(IsPrime.prime(value))
}
  
for divider in 2...max/2 {
  for (elemIndex, elem) in testArray.enumerated() {
    if case let .prime(value) = elem {
      if value != divider && value % divider == 0 {
        testArray[elemIndex] = .nonPrime(value)
      }
    }
  }
}

for elem in testArray {
  if case let .prime(value) = elem {
    print(value)
  }
}

}
