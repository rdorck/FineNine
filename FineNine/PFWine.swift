//
//  PFWine.swift
//  FineNine
//
//  Created by Robert Rock on 12/22/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import Foundation
import Parse

class PFWine: PFObject, PFSubclassing {
    
    //==========================================================================================================================
    // MARK: Properties
    //==========================================================================================================================
    
    var wineArray: NSMutableArray = NSMutableArray()
    @NSManaged var name: String?
    @NSManaged var photo: PFFile?
    @NSManaged var rating: Int
    @NSManaged var sweetness: Int
    @NSManaged var alcohol: Int
    @NSManaged var country: String?
    
    var image: UIImage?
    
    
    //==========================================================================================================================
    // MARK: PFSubclassing Protocol
    //==========================================================================================================================

    static func parseClassName() -> String {
        return "Wine"
    }
    
    
    //==========================================================================================================================
    // MARK: Initialization
    //==========================================================================================================================
    
    override init() {
        super.init()
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    
    //==========================================================================================================================
    // MARK: Methods
    //==========================================================================================================================
    
    func uploadWine() {
        if let image = image {
            let imageData = UIImageJPEGRepresentation(image, 0.8)!
            let photo = PFFile(data: imageData)
            photo?.saveInBackground()
            
            self.photo = photo
            saveInBackground()
        }
    }
    
    
}
