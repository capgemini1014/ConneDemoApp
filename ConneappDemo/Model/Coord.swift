//
//  Coord.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Coord : Codable {
    let lon : Double?
    let lat : Double?
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}
