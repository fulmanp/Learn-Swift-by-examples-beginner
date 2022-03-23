//
//  document.swift
//  ch_06
//
//  Created by Piotr Fulmański on 23/03/2022.
//

import Foundation

class Document: Codable {
  let uuid: UUID
  var path: String
  var checksum: [String:String]
  var tags: Set<String>
  var meta: Meta?
  
  convenience init(path: String, checksum: [String:String], tags: Set<String>, meta: Meta? = nil) {
    self.init(uuid: UUID(), path: path, checksum: checksum, tags: tags, meta: meta)
  }
  
  init(uuid: UUID, path: String, checksum: [String:String], tags: Set<String>, meta: Meta?) {
    self.uuid = uuid
    self.path = path
    self.checksum = checksum
    self.tags = tags
    self.meta = meta
  }
  
  
  /*
  From:
  https://stackoverflow.com/questions/29599005/how-to-serialize-or-convert-swift-objects-to-json
   
   // Encode
   let dog = Dog(name: "Rex", owner: "Etgar")

   let jsonEncoder = JSONEncoder()
   let jsonData = try jsonEncoder.encode(dog)
   let json = String(data: jsonData, encoding: String.Encoding.utf16)

   // Decode
   let jsonDecoder = JSONDecoder()
   let secondDog = try jsonDecoder.decode(Dog.self, from: jsonData)

   More informations:
   https://www.raywenderlich.com/3418439-encoding-and-decoding-in-swift
   */
  
  func describe() -> String? {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    var jsonData: Data?
    
    do {
        jsonData = try jsonEncoder.encode(self)
    } catch {
        // handle all errors
        print(error)
    }
    
    if let jsonData = jsonData {
      let json = String(data: jsonData, encoding: String.Encoding.utf8)
      return json
    }
    
    return nil
  }
}
