//
//  PokemonRowView.swift
//  PokemonApi
//
//  Created by David Ortega Muzquiz on 26/08/25.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: PokemonEntry
    
    var body: some View {
        Text(pokemon.name.capitalized)
            .font(.headline)
            .padding(.vertical, 4)
    }
}
