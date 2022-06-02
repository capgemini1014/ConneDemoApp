//
//  Weather.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id
        case main
        case description
        case icon
    }
}
