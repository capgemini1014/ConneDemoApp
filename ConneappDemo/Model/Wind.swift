//
//  Wind.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Wind : Codable {
    let speed : Double?
    let deg : Int?
    let gust : Double?

    enum CodingKeys: String, CodingKey {

        case speed
        case deg
        case gust
    }
}
