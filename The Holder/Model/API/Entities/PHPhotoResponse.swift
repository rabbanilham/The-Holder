//
//  PHPhotoResponse.swift
//  The Holder
//
//  Created by Bagas Ilham on 03/08/22.
//

import Foundation

struct PHPhotoResponse: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
