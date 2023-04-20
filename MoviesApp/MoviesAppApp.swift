//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
