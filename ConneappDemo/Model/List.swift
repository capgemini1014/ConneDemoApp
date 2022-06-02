//
//  List.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct List : Codable {
    let dt : Int?
    let main : Main?
    let weather : [Weather]?
    let clouds : Clouds?
    let wind : Wind?
    let visibility : Int?
    let sys : Sys?
    let dt_txt : String?

    enum CodingKeys: String, CodingKey {

        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case sys
        case dt_txt
    }

}
