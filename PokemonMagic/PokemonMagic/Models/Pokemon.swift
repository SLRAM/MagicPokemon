//
//  Pokemon.swift
//  PokemonMagic
//
//  Created by Stephanie Ramirez on 1/10/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let cards: [PokemonInfo]
}
struct PokemonInfo: Codable {
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let attacks: [Attack]
}
struct Attack: Codable {
    let name: String
    let damage: String
    let text: String
}
