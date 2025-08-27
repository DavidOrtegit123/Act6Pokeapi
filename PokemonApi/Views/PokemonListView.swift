//
//  PokemonListView.swift
//  PokemonApi
//
//  Created by David Ortega Muzquiz on 26/08/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var vm = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Cargando Pokémons...")
                } else if let error = vm.errorMessage {
                    VStack {
                        Text(error)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Reintentar") {
                            Task { await vm.fetchPokemons() }
                        }
                    }
                } else {
                    List(vm.pokemons) { pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                }
            }
            .navigationTitle("Pokémon")
            .task {
                await vm.fetchPokemons()
            }
        }
    }
}
