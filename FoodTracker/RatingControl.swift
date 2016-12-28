//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 28/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
    // MARK: - Properties
    private var ratingButtons = [UIButton]()
    var rating = 0
    

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    // MARK: - Button Action
    func ratingButtonTapped(button: UIButton) -> Void {
        print("Button pressed 👍")
    }

    
    // MARK: - Private Methods
    private func setupButtons() -> Void {
        for _ in 0..<5 {
            // Create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: UIControlEvents.touchUpInside)
            
            // Add button to the stack
            self.addArrangedSubview(button)
            
            // Add the new button to ratingButtons array
            ratingButtons.append(button)
        }
    }
    
    
}
