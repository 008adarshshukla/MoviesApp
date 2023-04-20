//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

//MARK: Movies Reults Model
struct MovieResults: Codable {
    let results: [MoviesModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

// MARK: Movies Model
struct MoviesModel: Codable {
    let id: Int?
    let originalLanguage: String?
    let originalTitle : String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

