//
//  RmTopLevel.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//

import Foundation

struct RmResponse : Codable {
    let info : Info?
    let results : [Character]?

    enum CodingKeys: String, CodingKey {

        case info = "info"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
        results = try values.decodeIfPresent([Character].self, forKey: .results)
    }

}


