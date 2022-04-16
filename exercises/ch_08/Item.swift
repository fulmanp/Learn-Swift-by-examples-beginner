//
//  Item.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

class Item {
  var fields: [Field]
  
  init() {
    fields = [Field]()
  }
  
  func getData() {
    var counter = 1
    
    for field in fields {
      while true {
        var req = ""
        if field.required {
          req = " (this field is required) "
        }
        
        print("\(counter), field name\(req)\(field.name):")
        
        if let text = readLine() {
          if !text.isEmpty {
            if field.set(text) {
              break;
            } else {
              print("This is not correct, please try again.")
            }
          } else {
            if field.required {
              print("This field is required, please enter valid data")
            } else {
              break
            }
          }
        } else {
          print("Some problems detected, please try again")
        }
      }
      counter += 1
    }
  }
  
  func printInformations() {
    var counter = 1
    
    for field in fields {
      print("\(counter), \(field.name): \(field.toString())")
      
      counter += 1
    }
  }
}
