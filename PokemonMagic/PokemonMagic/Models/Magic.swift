//
//  Magic.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import Foundation

struct Magic: Codable {
    let cards: [MagicInfo]
}
struct MagicInfo: Codable {
    let name: String
    let imageUrl: String?
    let text: String
    let foreignNames: [ForeignInfo]
}
struct ForeignInfo: Codable {
    let name: String
    let text: String
    let imageUrl: String
    let language: String
}
