//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Marko Anton Potocnik on 27/12/2016.
//  Copyright © 2016 Marko Anton Potocnik. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either 
     passed by `MealTableViewController` in `prepare(for:sender:)`,
     or constructed as part of adding a new meal
    */
    var meal: Meal?
    
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        // Enable the save button only if text field has a valid name
        updateSaveButtonState()
    }
    
    
    // MARK: - UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button while editing
        saveButton.isEnabled = false
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if user canceled
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but it has provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected photo
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        self.dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure the view before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view only when save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed. Cancelling.", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let rating = ratingControl.rating
        let photo = photoImageView.image
        
        // Set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, rating: rating, photo: photo)
        
    }
    
    
    // MARK: - Actions    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets user pick a media from their photo library
        let imagePickerContorller = UIImagePickerController()
        // Only allows photos to be picked not taken
        imagePickerContorller.sourceType = .photoLibrary

        // Make sure ViewController is notified when user picks an image
        imagePickerContorller.delegate = self
        
        self.present(imagePickerContorller, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Private Methods
    private func updateSaveButtonState() {
        // Disable save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

