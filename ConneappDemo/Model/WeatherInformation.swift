//
//  WeatherInformation.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct WeatherInformation: Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [List]?
    let city : City?

    enum CodingKeys: String, CodingKey {

        case cod
        case message
        case cnt
        case list
        case city
    }
}
