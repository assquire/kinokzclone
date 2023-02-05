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
        static let urlList = [URLs.trending, URLs.nowPlaying, URLs.popular, URLs.topRated, URLs.upcoming]
    }
    
    struct Links {
        static let apiLink = "https://api.themoviedb.org/3/"
        static let imageLink = "https://image.tmdb.org/t/p/w500/"
    }
    
    struct URLs  {
        static let trending = "\(Links.apiLink)trending/movie/day?api_key=\(Keys.api)"
        static let nowPlaying = "\(Links.apiLink)movie/now_playing?api_key=\(Keys.api)"
        static let popular = "\(Links.apiLink)movie/popular?api_key=\(Keys.api)"
        static let topRated = "\(Links.apiLink)movie/top_rated?api_key=\(Keys.api)"
        static let upcoming = "\(Links.apiLink)movie/upcoming?api_key=\(Keys.api)"
    }
    
    // https://api.themoviedb.org/3/movie/popular?api_key=b546d4933841b9453fa9ccabe482d1a8&language=en-US&page=1
}

enum MovieType: String, CaseIterable {
    case all = "All"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
}
