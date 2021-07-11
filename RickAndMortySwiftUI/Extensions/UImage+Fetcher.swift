//
//  UImage+Fetcher.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//

import SwiftUI

extension Image {
    
    func data(url: URL?) -> Self {
        guard let imageUrl = url else { return self}
        if let data = try? Data(contentsOf: imageUrl) {
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self.resizable()
    }
}

