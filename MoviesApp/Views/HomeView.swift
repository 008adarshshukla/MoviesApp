//
//  ContentView.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    CarouselView()
                    
                    Text("Streaming Now")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.moviesResult, id: \.self) { movie in
                                MoviesCardView(movie: movie)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleTextColor(.white)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavigationBarItem()
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    leadingNavigationBarItem()
                }
            })
        }
        .toolbarBackground(Color.black, for: .tabBar)
        .task {
            do {
                try await viewModel.getMovies()
            } catch {
                print("error fetching movies.")
            }
        }
    }
    
    //MARK: Leading Navigation Bar Item
    @ViewBuilder
    func leadingNavigationBarItem() -> some View {
        Image(systemName: "line.3.horizontal")
             .foregroundColor(.white)
             .font(.title2)
             .bold()
    }
    
    //MARK: Trailing Navigation Bar Item
    @ViewBuilder
    func trailingNavigationBarItem() -> some View {
        Circle()
            .fill(AngularGradient(colors: [Color.red, Color.blue], center: .bottomTrailing, angle: .degrees(45)))
            .frame(width: 50, height: 50)
            .overlay(alignment: .center) {
                Image(systemName: "person.fill")
            }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MoviesViewModel())
    }
}


