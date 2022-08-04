//
//  PHAlbumResponse.swift
//  The Holder
//
//  Created by Bagas Ilham on 03/08/22.
//

import Foundation

struct PHAlbumResponse: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
