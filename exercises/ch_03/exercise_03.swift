//
//  exercise_03.swift
//  exercise_03
//
//  Created by Piotr Fulmański on 02/03/2022.
//

import Foundation

//
// Selection sort
// https://en.wikipedia.org/wiki/Selection_sort
//
func exercise_03() {
  
var data = [8,5,2,7,4,6,0,3]

var currentIndex: Int
var minimumIndex = 0
  
print(data)
  
for exhangeIndex in 0...data.count-2 {
  minimumIndex = exhangeIndex
  currentIndex = exhangeIndex + 1
  
  for _ in (exhangeIndex + 1)...(data.count-1) {
    if data[minimumIndex] > data[currentIndex] {
      minimumIndex = currentIndex
    }
    currentIndex += 1
  }
  
  if exhangeIndex != minimumIndex {
    print("Swap \(data[exhangeIndex]) with \(data[minimumIndex])")
    data.swapAt(exhangeIndex, minimumIndex)
  } else {
    print("Nothing to swap")
  }
  print(data)
  
}
  
}
