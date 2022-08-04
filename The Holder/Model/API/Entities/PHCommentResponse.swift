//
//  PHCommentResponse.swift
//  The Holder
//
//  Created by Bagas Ilham on 02/08/22.
//

import Foundation

struct PHCommentResponse: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
