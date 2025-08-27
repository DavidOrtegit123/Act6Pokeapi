//
//  PokemonDetailView.swift
//  PokemonApi
//
//  Created by David Ortega Muzquiz on 26/08/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonEntry
    @State private var detail: PokemonDetail?
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            if let detail = detail {
                VStack(spacing: 16) {
                    if let imgURL = detail.sprites.front_default,
                       let url = URL(string: imgURL) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                    }
                    
                    Text(detail.name.capitalized)
                        .font(.largeTitle.bold())
                    
                    Text("Height: \(detail.height)")
                    Text("Weight: \(detail.weight)")
                }
                .padding()
            } else if isLoading {
                ProgressView("Cargando detalles...")
            } else {
                Text("No se pudo cargar el detalle.")
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadDetail()
        }
    }
    
    func loadDetail() async {
        isLoading = true
        let vm = PokemonViewModel()
        detail = await vm.fetchDetail(from: pokemon.url)
        isLoading = false
    }
}
