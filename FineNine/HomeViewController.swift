//
//  ProfileViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/11/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit
import Parse
import Bolts

class HomeViewController: UIViewController, UINavigationControllerDelegate {

    //==========================================================================================================================
    // MARK: Properties
    //==========================================================================================================================

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

    
    //==========================================================================================================================
    // MARK: Navigation
    //==========================================================================================================================


}
