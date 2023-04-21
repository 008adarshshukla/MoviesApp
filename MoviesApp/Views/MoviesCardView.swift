//
//  MoviesCardView.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

struct MoviesCardView: View {
    
    @EnvironmentObject var viewModel: MoviesViewModel
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    let movie: MoviesModel
    @State private var isTapped: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: viewModel.imageUrlPrefix + (movie.posterPath ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    coreDataViewModel.addFavouriteMovie(title: movie.originalTitle ?? "", voteAverage: movie.voteAverage ?? 0.0)
                                } label: {
                                    Image(systemName: "star.fill")
                                        .font(.title2)
                                        .foregroundColor(isTapped ? .yellow : .white)
                                }
                                
                            }
                        
                    case .failure( _):
                        Image(systemName: "questionmark")
                            .font(.headline)
                        
                    default:
                        Image(systemName: "questionmark")
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                Text(movie.originalTitle ?? "")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
                
            }
            .frame(width: 200, height: 270)
        }
    }
}

struct MoviesCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MoviesViewModel())
            .environmentObject(CoreDataViewModel())
    }
}

