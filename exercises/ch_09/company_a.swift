//
//  company_a.swift
//  ch_09
//
//  Created by Piotr Fulmański on 22/04/2022.
//

import Foundation

class Pump {
  var serialNumber: String
  var capacity: Int?
  var weight: Int?
  
  init(serialNumber: String) {
    self.serialNumber = serialNumber
  }
}
