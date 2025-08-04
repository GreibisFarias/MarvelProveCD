//
//  NetworkCall.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 7/29/25.
//

import Foundation
import Combine


class MarvelViewModel: ObservableObject {
    @Published var Characters: [MarvelCharacters] = []
    @Published var errorMensaje: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchPersonas() {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?apikey=7501a5faaace056b936fce03b2b6e8f9&ts=1&hash=08033e0b15a19f7e4a7daf47ef3babfc&orderBy=-modified" ) else {
            self.errorMensaje = "Invalid URL"
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: Marvel.self, decoder: JSONDecoder())
            .map { $0.data.results }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorMensaje = "Failed to load: \(error.localizedDescription)"
                }
            } receiveValue: { characters in
                self.Characters = characters
            }
            .store(in: &cancellables)
    }
}


