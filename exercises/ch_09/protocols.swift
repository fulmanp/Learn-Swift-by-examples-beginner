//
//  protocols.swift
//  ch_09
//
//  Created by Piotr Fulmański on 22/04/2022.
//

import Foundation

protocol UniquelyIdentifiable {
    func getID() -> String
}
protocol Namable {
    func getName() -> String
}
protocol Stringable {
    func getString() -> String
}
