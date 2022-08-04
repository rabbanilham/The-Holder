//
//  PlaceholderAPI.swift
//  The Holder
//
//  Created by Bagas Ilham on 01/08/22.
//

import Foundation
import Alamofire

struct PlaceholderAPI {
    static let shared = PlaceholderAPI()
    let baseUrl = "https://jsonplaceholder.typicode.com/"
    
    func getPosts(
        _ completion: @escaping ([PHPostResponse]?, AFError?) -> Void
    ) {
        AF.request(baseUrl + "posts")
            .validate()
            .responseDecodable(of: [PHPostResponse].self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getComments(
        _ postID: Int,
        _ completion: @escaping ([PHCommentResponse]?, AFError?) -> Void
    ) {
        AF.request(baseUrl + "posts/\(postID)/comments")
            .validate()
            .responseDecodable(of: [PHCommentResponse].self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getUserById(
        _ userId: Int,
        _ completion: @escaping (PHUserResponse?, AFError?) -> Void
    ) {
        AF.request(baseUrl + "users/\(userId)")
            .validate()
            .responseDecodable(of: PHUserResponse.self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getAlbums(
        userId: Int,
        _ completion: @escaping ([PHAlbumResponse]?, AFError?) -> Void
    ) {
        AF.request(baseUrl + "users/\(userId)/albums")
            .validate()
            .responseDecodable(of: [PHAlbumResponse].self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getAlbumPhotos(
        albumId: Int,
        _ completion: @escaping ([PHPhotoResponse]?, AFError?) -> Void
    ) {
        AF.request(baseUrl + "albums/\(albumId)/photos")
            .validate()
            .responseDecodable(of: [PHPhotoResponse].self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
}
