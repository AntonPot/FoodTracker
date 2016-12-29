//
//  Meal.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 29/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: - Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    
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
    
}
