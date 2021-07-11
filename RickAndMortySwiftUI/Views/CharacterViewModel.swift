//
//  CharacterViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var loading = true
    
    var resultInfo: Info?
    var cancellationToken: AnyCancellable?
    
    let networkService: NetworkService
    var endData = false
    var currentPage = 1
    
    init() {
        networkService = NetworkService(host: .rickAndMortyBase)
        getCharacters()
    }
}

extension CharacterViewModel {
    func getCharacters() {
        loading = true
        networkService.setupRequest(path: Constants.kCharacterPath, params: [Constants.kPageParam : "\(currentPage)"])
        cancellationToken = networkService.performRequest()
            .mapError({ (error) -> Error in
                print(error)
                return error
            }).sink(receiveCompletion: { _ in },
                    receiveValue: {
                        self.characters.append(contentsOf: $0.results ?? [])
                        self.resultInfo = $0.info
                        self.currentPage += 1
                        if self.resultInfo?.next == nil {
                            self.endData = true
                        }
                        self.loading = false
            })
    }
}
