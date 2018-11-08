//
//  Tune.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation

struct Tune: Codable {
    
    struct Album: Codable {
        let coverSmall : String?
        let coverMedium: String?
        enum CodingKeys : String, CodingKey {
            case coverSmall = "cover_small"
            case coverMedium = "cover_medium"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coverSmall = try values.decode(String.self, forKey: .coverSmall)
            coverMedium = try values.decode(String.self, forKey: .coverMedium)
        }
    }
    struct Songs: Codable {
        let title : String?
        let preview: String?
        let album: Album?
        enum CodingKeys : String, CodingKey {
            case title = "title"
            case preview = "preview"
            case album = "album"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decode(String.self, forKey: .title)
            preview = try values.decode(String.self, forKey: .preview)
            album = try values.decode(Album.self, forKey: .album)
        }
    }
    
    let data : [Songs]?
    let next: String?
    enum CodingKeys : String, CodingKey {
        case data = "data"
        case next =  "next"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([Songs].self, forKey: .data)
        next = try values.decode(String.self, forKey: .next)
    }
}

