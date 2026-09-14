//
//  Planet.swift
//  Navigation
//
//  Created by Mysty Mystylal on 14.09.2026.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let orbitalPeriod: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
    }
}
