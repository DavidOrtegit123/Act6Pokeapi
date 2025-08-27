//
//  Pokemon.swift
//  PokemonApi
//
//  Created by David Ortega Muzquiz on 26/08/25.
//

import Foundation

// Respuesta del listado
struct PokemonResponse: Decodable {
    let results: [PokemonEntry]
}

// Cada pokémon de la lista
struct PokemonEntry: Decodable, Identifiable {
    let name: String
    let url: String
    
    var id: String { url }
}

// Detalle de un pokémon (para imagen, peso, altura, etc.)
struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let front_default: String?
    }
}
