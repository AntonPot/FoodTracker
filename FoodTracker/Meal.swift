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
        // Initialization should fail if there's no name or rating is less than 0
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.rating = rating
        self.photo = photo
    }
    
}
