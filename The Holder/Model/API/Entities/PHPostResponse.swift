//
//  PHPostResponse.swift
//  The Holder
//
//  Created by Bagas Ilham on 01/08/22.
//

import Foundation

struct PHPostResponse: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
