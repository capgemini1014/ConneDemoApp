//
//  Main.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Main : Codable {
    let temp : Double?
    enum CodingKeys: String, CodingKey {

        case temp
    }

}
