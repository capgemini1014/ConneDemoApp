//
//  Sys.swift
//  ConneappDemo
//
//  Created by Santanu on 29/05/2022.
//

import Foundation
struct Sys : Codable {
    let pod : String?

    enum CodingKeys: String, CodingKey {
        case pod
    }

}
