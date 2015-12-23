//
//  WineViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/21/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit

class WineViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    
    @IBOutlet weak var wineTextField: UITextField!
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var wine: Wine?
    var pfWine: PFWine?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wineTextField.delegate = self
        
        if let wine = pfWine {
            navigationItem.title = wine.name
            wineTextField.text = wine.name
            wineImageView.image = wine.image
            ratingControl.rating = wine.rating
        }
        
        checkValidWineName()
    }

    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidWineName() {
        let text = wineTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidWineName()
        navigationItem.title = wineTextField.text
    }
    
    
    // MARK: ImagePickerController Delegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        wineImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Navigation
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        let isPresentingInAddWineMode = presentingViewController is UINavigationController
        //print("true or false: \(isPresentingInAddWineMode)")
       
        if isPresentingInAddWineMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
   
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = wineTextField.text ?? ""
            let image = wineImageView.image
            let rating = ratingControl.rating
            
            //wine = Wine(name: name, photo: photo, rating: rating)
            
            pfWine = PFWine()
            pfWine?.name = name
            pfWine?.image = image
            pfWine?.rating = rating
            pfWine?.uploadWine()
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        wineTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .PhotoLibrary

        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
  

}
