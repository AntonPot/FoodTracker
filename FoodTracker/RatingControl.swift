//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 28/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: - Properties
    private var ratingButtons = [UIButton]()
    var rating: Int = 0 {
        didSet { updateButtonSelectionStates() }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet { setupButtons() }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet { setupButtons() }
    }
    

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
//        print("Button pressed 👍")
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button \(button) is not in ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If user pressed a star representing current rating, set rating to 0
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    
    // MARK: - Private Methods
    private func setupButtons() -> Void {
        
        // Clear view of existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount {
            // Create the button
            let button = UIButton()
            button.setImage(emptyStar, for: UIControlState.normal)
            button.setImage(filledStar, for: UIControlState.selected)
            button.setImage(highlightedStar, for: UIControlState.highlighted)
            button.setImage(highlightedStar, for: [UIControlState.highlighted, UIControlState.selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set accessabilty label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: UIControlEvents.touchUpInside)
            
            // Add button to the stack
            self.addArrangedSubview(button)
            
            // Add the new button to ratingButtons array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() -> Void {
        for (index, button) in ratingButtons.enumerated() {
            // Set button state to selected, if it's index is less than rating
            button.isSelected = index < rating
            
            // Set hintString for currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap here to reset rating back to 0"
            } else {
                hintString = nil
            }
            
            // Calculate valueString
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star rating"
            default:
                valueString = "\(rating) stars rating"
            }
            
            // Assign hintString and valueString
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}









