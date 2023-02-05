//
//  Constants.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import Foundation

struct Constants {
    
    struct Keys {
        static let api = "b546d4933841b9453fa9ccabe482d1a8"
    }
    
    struct Identifiers {
        static let sectionCollectionViewCell = "SectionCollectionViewCell"
        static let trendingCollectionViewCell = "TrendingCollectionViewCell"
        static let movieTableViewCell = "MovieTableViewCell"
        static let movieCollectionViewCell = "MovieCollectionViewCell"
    }
    
    struct Colors {
        
    }
    
    struct Values {
        static let tabBarItems = ["Poster", "Theaters", "My Tickets", "Profile"]
    }
    
    struct Links {
        static let apiUrl = "https://api.themoviedb.org/3/"
        static let trendingUrl = "\(apiUrl)trending/movie/day?api_key=\(Keys.api)"
        static let imageUrl = "https://image.tmdb.org/t/p/w500/"
        
// https://api.themoviedb.org/3/trending/movie/day?api_key=b546d4933841b9453fa9ccabe482d1a8
    }
}

enum MediaType: String, CaseIterable {
    case trending = "Trending"
    case all = "All"
    case streaming = "Streaming"
    case onTV = "On TV"
    case inTheaters = "In Theaters"
}
