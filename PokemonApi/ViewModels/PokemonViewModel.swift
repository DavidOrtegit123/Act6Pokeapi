//
//  ContentView.swift
//  PokemonApi
//
//  Created by David Ortega Muzquiz on 26/08/25.
//

import SwiftUI

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [PokemonEntry] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPokemons() async {
        isLoading = true
        errorMessage = nil
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=20"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)
            self.pokemons = decoded.results
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func fetchDetail(from urlString: String) async -> PokemonDetail? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
            return decoded
        } catch {
            print("Error detail: \(error)")
            return nil
        }
    }
}
