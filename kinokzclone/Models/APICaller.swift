//
//  APICaller.swift
//  kinokzclone
//
//  Created by Askar on 19.01.2023.
//

import Foundation

protocol APICallerDelegate {
    func didUpdateMovieList(with movieList: [MovieModel])
    func didFailWithError(_ error: Error)
}

struct APICaller {
    
    var delegate: APICallerDelegate?
    
    func fetchRequest() {
        let urlString = Constants.Links.trendingUrl
        guard let url = URL(string: urlString) else { fatalError("Incorrect link!") }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let movieList = parseJSON(data) {
                    delegate?.didUpdateMovieList(with: movieList)
                } else {
                    delegate?.didFailWithError(error!)
                }
            } else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [MovieModel]? {
        var movieList: [MovieModel] = []
        do {
            let decodedData = try JSONDecoder().decode(MovieData.self, from: data)
            for movie in decodedData.results {
                let movieModel = MovieModel(adult: movie.adult, id: movie.id, title: movie.title, originalTitle: movie.original_title, description: movie.overview, posterPath: movie.poster_path, genreIds: movie.genre_ids, releaseDate: movie.release_date, voteAverage: movie.vote_average, voteCount: movie.vote_count)
                movieList.append(movieModel)
            }
            return movieList
        } catch {
            print(error)
            return nil
        }
    }
}
