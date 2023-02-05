//
//  MovieModel.swift
//  kinokzclone
//
//  Created by Askar on 31.01.2023.
//

import Foundation

struct MovieModel {
    let adult: Bool
    let id: Int
    let title: String
    let originalTitle: String
    let description: String
    let posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
