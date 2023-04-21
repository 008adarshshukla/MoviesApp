//
//  FileManager.swift
//  MoviesApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting data from UIImage.")
            return
        }
        
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        
        //creating path from directory.
        let path = directory?.appendingPathComponent("\(name).jpeg")
        
        guard let path = path else {
            return
        }
        
        do {
            try data.write(to: path)
            print("Success Saving Image.")
        } catch let error {
            print("Error saving image file manager: \(error.localizedDescription)")
        }
    }
    
    func getImage(name: String) -> UIImage?  {
        
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let path = directory?.appendingPathComponent("\(name).jpeg")
        
        guard
            let path = path?.path,
            FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
                let path = directory?.appendingPathComponent("\(name).jpeg")
        
        guard let path = path,
              FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting the path.")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch let error {
            print("Error deleting the image \(error.localizedDescription)")
        }
    }
}
