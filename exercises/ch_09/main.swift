//
//  main.swift
//  ch_09
//
//  Created by Piotr Fulmański on 22/04/2022.
//

import Foundation

let pump1 = Pump(serialNumber: "ZXV1234GZB")
pump1.weight = 123
pump1.capacity = 45
let pump2 = Pump(serialNumber: "ZXV1234HND")
pump1.weight = 67
pump1.capacity = 89


let device1 = Device(deviceType: .pump, identifier: "pump_2022_ZXV1234GZB")
device1.weight = 123
let device2 = Device(deviceType: .pump, identifier: "pump_2022_ZXV1234HND")
device2.weight = 67

print(pump1.getString())
print(device1.getString())
