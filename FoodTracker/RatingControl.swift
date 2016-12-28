//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 28/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

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
        // Create the button
        let button = UIButton()
        button.backgroundColor = UIColor.red
//        button.backgroundColor = .red
        
        // Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        // Setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // Add button to the stack
        self.addArrangedSubview(button)
    }
    
    
}
