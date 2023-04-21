//
//  CarouselView.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

struct CarouselView: View {
    
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        TabView {
            ForEach(viewModel.moviesResult, id: \.self) { movie in
                AsyncImage(url: URL(string: viewModel.imageUrlPrefix + (movie.posterPath ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 380)
                            .cornerRadius(10)
                        
                    case .failure( _):
                        Image(systemName: "questionmark")
                            .font(.headline)
                        
                    default:
                        Image(systemName: "questionmark")
                            .font(.headline)
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .environmentObject(MoviesViewModel())
    }
}

