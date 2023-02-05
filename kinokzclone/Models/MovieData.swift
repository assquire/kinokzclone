//
//  MoviesResponse.swift
//  kinokzclone
//
//  Created by Askar on 30.01.2023.
//

import Foundation

struct MovieData: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let adult: Bool
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
    let vote_count: Int
}
