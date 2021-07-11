//
//  Character.swift
//  RickAndMortySwiftUI
//
//  Created by Jake O'Dowd on 7/10/21.
//


import Foundation

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "Unknown"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

struct Character : Codable, Identifiable, Hashable {
    let id = UUID()
    let name : String?
    let status : String?
    let species : String?
    let type : String?
    let gender : String?
    let origin : Origin?
    let location : Location?
    let image : String?
    let episode : [String]?
    let url : String?
    let created : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case image = "image"
        case episode = "episode"
        case url = "url"
        case created = "created"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        species = try values.decodeIfPresent(String.self, forKey: .species)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        episode = try values.decodeIfPresent([String].self, forKey: .episode)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        created = try values.decodeIfPresent(String.self, forKey: .created)
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
