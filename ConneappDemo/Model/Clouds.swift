//
//  Clouds.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Clouds : Codable {
    let all : Int?
    enum CodingKeys: String, CodingKey {
        case all
    }
}
