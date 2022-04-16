//
//  Group.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

class Group {
  var name: String
  var fieldType: [FieldType]
  var data: [Item]
  
  init(name: String) {
    self.name = name
    fieldType = [FieldType]()
    data = [Item]()
  }
  
  func getItem() -> Item {
    let item = Item()
    
    for ft in fieldType {
      switch ft {
      case let .email(name, required):
        let field = FieldEmail(name: name ?? "undefined", required: required)
        item.fields.append(field)
      case let .note(name, required):
        let field = FieldNote(name: name ?? "undefined", required: required)
        item.fields.append(field)
      case let .text(name, required):
        let field = FieldText(name: name ?? "undefined", required: required)
        item.fields.append(field)
      default:
        print("Unexpected filed")
      }
    }
    
    return item
  }
  
  func storeData(_ item: Item) {
    data.append(item)
  }
}
