//
//  FavouriteMoviesView.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

struct FavouriteMoviesView: View {
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .opacity(1)
                    .ignoresSafeArea()
                
                VStack {
                    if coreDataViewModel.savedMovieEntities.count == 0 {
                        VStack {
                            Image("Nothing")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)

                            Text("Nothing in Favourites yet...")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    if coreDataViewModel.savedMovieEntities.count != 0 {
                        List {
                            
                            ForEach(coreDataViewModel.savedMovieEntities) { entity in
                                favouriteListRow(entity: entity)
                            }
                            .onDelete { indexSet in
                                coreDataViewModel.deleteMovie(indexSet: indexSet)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background {
                            Color.black
                        }
                    }
                }
                .navigationTitle("Favourites...")
                .navigationBarTitleTextColor(.white)
                .font(.title2)
            }
        }
    }
    
    @ViewBuilder
    func favouriteListRow(entity: FavouriteMoviesEntity) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 120, height: 120)
            VStack(alignment: .leading) {
                Text(entity.title ?? "")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()
                HStack {
                    Image(systemName: "hand.thumbsup.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%.1f", entity.voteAverage))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}



struct FavouriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMoviesView()
            .environmentObject(CoreDataViewModel())
    }
}



