//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Marko Anton Potocnik on 27/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: - Meal Class Tests
    // Confirm that Meal initializer returns a Meal object when passing valid parameters
    func testMealInitializationSucceeds() {
        
        // Zero rating
        let zeroRatingMeal = Meal(name: "Zero", rating: 0, photo: nil)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest possible rating
        let positiveRatingMeal = Meal(name: "Five", rating: 5, photo: nil)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    // Confirm that Meal initialization returns nil when passed negative rating or an empty name
    func testMealInitializationFails() {
        
        // Negative rating
        let negativeRatingMeal = Meal(name: "Negative", rating: -1, photo: nil)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal(name: "Large", rating: 6, photo: nil)
        XCTAssertNil(largeRatingMeal)
        
        // Empty String
        let emptyNameMeal = Meal(name: "", rating: 3, photo: nil)
        XCTAssertNil(emptyNameMeal)
    }
    
}
