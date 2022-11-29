//
//  company_b.swift
//  ch_09
//
//  Created by Piotr Fulmański on 22/04/2022.
//

import Foundation

enum DeviceType: String {
  case pump, motor, compressor
}

class Device {
  var deviceType: DeviceType
  var identifier: String
  var weight: Double?
  
  init(deviceType: DeviceType, identifier: String) {
    self.deviceType = deviceType
    self.identifier = identifier
  }
}
