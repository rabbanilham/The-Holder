//
//  PHUserResponse.swift
//  The Holder
//
//  Created by Bagas Ilham on 01/08/22.
//

import Foundation

struct PHUserResponse: Codable {
    let id: Int
    let name, username, email: String
    let address: PHAddressResponse
    let phone, website: String
    let company: PHCompanyResponse
}

struct PHAddressResponse: Codable {
    let street, suite, city, zipcode: String
    let geo: PHGeoResponse
}

struct PHGeoResponse: Codable {
    let lat, lng: String
}

struct PHCompanyResponse: Codable {
    let name, catchPhrase, bs: String
}
