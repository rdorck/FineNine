//
//  RatingControl.swift
//  FineNine
//
//  Created by Robert Rock on 12/21/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    //==========================================================================================================================
    // MARK: Properties
    //==========================================================================================================================
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    var spacing = 5
    var stars = 5

    //==========================================================================================================================
    // MARK: Initialization
    //==========================================================================================================================
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledGlassImage = UIImage(named: "filledGlass")
        let emptyGlassImage = UIImage(named: "emptyGlass")
        
        for _ in 0..<stars {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            button.setImage(emptyGlassImage, forState: .Normal)
            button.setImage(filledGlassImage, forState: .Selected)
            button.setImage(filledGlassImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y:0, width:  buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    //==========================================================================================================================
    // MARK: Actions
    //==========================================================================================================================
    
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
    
        updateButtonSelectionStates()
    }
    
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating
        }
    }
    
    
    
    
}
