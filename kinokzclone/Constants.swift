//
//  Constants.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import Foundation

struct Constants {
    
    struct Keys {
        
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
}

enum MediaType: String, CaseIterable {
    case trending = "Trending"
    case all = "All"
    case streaming = "Streaming"
    case onTV = "On TV"
    case inTheaters = "In Theaters"
}
