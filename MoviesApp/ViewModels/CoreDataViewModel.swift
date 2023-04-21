//
//  CoreDataViewModel.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedMovieEntities: [FavouriteMoviesEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FavouriteMoviesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Erroe Loading Core Data \(error)")
            }else {
                print("Successfully loaded Core Data.")
            }
        }
        fetchFavouriteMovies()
    }
    
    //MARK: Function to favourite fetch movies.
    func fetchFavouriteMovies() {
        let request = NSFetchRequest<FavouriteMoviesEntity>(entityName: "FavouriteMoviesEntity")
        do {
            savedMovieEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching the container \(error)")
        }
    }
    
    //MARK: Function to add a favourite Movie.
    func addFavouriteMovie(title: String, voteAverage: Double) {
        let newMovie = FavouriteMoviesEntity(context: container.viewContext)
        newMovie.title = title
        newMovie.voteAverage = voteAverage
        saveData()
    }
    
    //MARK: Saving the favourite movie.
    func saveData() {
        do {
            try container.viewContext.save()
            print("Data saved Successfully")
            fetchFavouriteMovies()
        } catch let error {
            print("Error Saving the data \(error)")
        }
    }
    
    //MARK: Deleting a favourite movie.
    func deleteMovie(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let entity = savedMovieEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
}
