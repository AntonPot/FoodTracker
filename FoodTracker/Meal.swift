//
//  Meal.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 29/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // MARK: - Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    
    // MARK: - Archiving Paths
//    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendPathComponent("meal")
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    
    // MARK: - Types
    struct PropertyKey {
        static let name = "name"
        static let rating = "rating"
        static let photo = "photo"
    }
    
    
    // MARK: - Initializers
    init?(name: String, rating: Int, photo: UIImage?) {
        
        // Name must not be empty
        guard !name.isEmpty else { return nil }
        // Rating must be between 0 and 5
        guard (rating >= 0) && (rating <= 5) else { return nil }
        
        // Initialize stored properties
        self.name = name
        self.rating = rating
        self.photo = photo
    }

    
    // MARK: - NSCoding Methods
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required, if we cannot decode the name string the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for Meal object", log: OSLog.default, type: .debug)
            return nil
        }
        
        let rating = aDecoder.decodeObject(forKey: PropertyKey.rating) as! Int
        
        // Because photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // Must call designated initializer
        self.init(name: name, rating: rating, photo: photo)
    }
}
