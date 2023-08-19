//
//  Endpoint.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit


enum Endpoint {
    case movies_week
    case movies_day
    case tv_week
    case tv_day
    
    var requestURL: String {
        switch self {
        case .movies_day: return URL.makeEndPointString("trending/movie/day")
        case .movies_week: return URL.makeEndPointString("trending/movie/week")
        case .tv_day: return URL.makeEndPointString("trending/tv/day")
        case .tv_week: return URL.makeEndPointString("trending/tv/week")
        }
    }
}


enum GenreList {
    case movie_genre
    case tv_genre
    
    
    var requestURL: String {
        switch self {
        case .movie_genre: return URL.makeEndPointString("genre/movie/list")
        case .tv_genre: return URL.makeEndPointString("genre/tv/list")
        }
    }
}




