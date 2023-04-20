//
//  ErrorModel.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 20/04/23.
//

import SwiftUI

enum NetworkError: Error {
    case invalidResponse
    case decodingError
}
