//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    
    @Published var moviesResult: [MoviesModel] = []
    
    let apiKey = "your api key"
    let imageUrlPrefix = "https://image.tmdb.org/t/p/w500"
    
    
    func getMovies() async throws {
        //given url
        var urlString = "https://api.themoviedb.org/3/movie/now_playing"
        //appending the api key to the end point.
        urlString.append("?api_key=\(apiKey)")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let (data, respose) = try await URLSession.shared.data(from: url)
        guard let httpResponse = respose as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let returnedResult = try? JSONDecoder().decode(MovieResults.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        self.moviesResult = returnedResult.results
        
    }
}
