//
//  CharacterListView.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//

import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters, id: \.self) { character in
                    HStack {
                        Image(systemName: "person.fill")
                            .data(url: URL(string: character.image ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                        
                        VStack(alignment: .center, spacing: 25) {
                            Text(character.name ?? "").font(.headline)
                            HStack(alignment: .bottom) {
                                Text("Status: \(character.status ?? "")").font(.subheadline)
                                Text("Species: \(character.species ?? "")").font(.subheadline)
                            }
                        }
                    }
                }
                .id(UUID())
                
                if !viewModel.endData {
                    HStack(alignment: .center) {
                        ActivityIndicatorView(isAnimating: .constant(self.viewModel.loading), style: .large)
                    }
                    self.onAppear {
                        viewModel.getCharacters()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("rick-morty-title")
                }
            }
            .navigationBarTitle("Rick and Morty API")
            //.navigationBarTitle(Text("Rick and Morty API"), displayMode: .inline)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = .blue.withAlphaComponent(0.1)
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.blue,
            .font : UIFont(name:"Futura-Bold", size: 40)!
        ]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
