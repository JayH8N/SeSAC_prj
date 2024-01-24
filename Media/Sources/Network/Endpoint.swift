//
//  Endpoint.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit


enum EndpointTrending {
    case movies_day
    case movies_week
    case tv_day
    case tv_week
    
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


enum TVSeries {
    case tvSeries_airingToday
    case tvSeries_Popular
    case tv
    
    var requestURL: String {
        switch self {
        case .tvSeries_airingToday: return URL.makeEndPointString("tv/airing_today")
        case .tvSeries_Popular: return URL.makeEndPointString("tv/popular")
        case .tv: return URL.makeEndPointString("tv/")
        }
    }
}

enum TVOption {
    case similar
    case recommendations
    
    var requestURL: String {
        switch self {
        case .similar: return "similar"
        case .recommendations: return "recommendations"
        }
    }
}
