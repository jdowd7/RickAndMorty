//
//  CharacterDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/13/21.
//

import Foundation
import SwiftUI

struct CharacterDetailView: View {
    
  let character: Character
    
  var body: some View {
    HStack {
        VStack(alignment: .center, spacing: 25) {
            Text(character.name ?? "").font(.headline)
            Text("Status: \(character.location?.name ?? "")").font(.subheadline)
        }
    }
  }
}
