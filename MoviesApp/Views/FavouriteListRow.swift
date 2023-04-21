//
//  FavouriteListRow.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

struct FavouriteListRow: View {
    
    let entity: FavouriteMoviesEntity
    @State private var image: UIImage? = nil
    
    var body: some View {
        HStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 120, height: 120)
            }
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
        .onAppear {
            self.image = LocalFileManager.instance.getImage(name: entity.title ?? "No title")
        }
    }
}

