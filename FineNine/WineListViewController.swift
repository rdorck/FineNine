//
//  WineListViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/21/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit

class WineListViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: Properties
    
    var wines = [Wine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleWines()
    }

    
    func loadSampleWines() {
        
        let photo1 = UIImage(named: "carnivor")
        let wine1 = Wine(name: "Carnivor", photo: photo1, rating: 5)!
        
        let photo2 = UIImage(named: "classico")
        let wine2 = Wine(name: "Chianti Classico", photo: photo2, rating: 3)!
        
        let photo3 = UIImage(named: "cassana")
        let wine3 = Wine(name: "Cassana", photo: photo3, rating: 2)!
        
        let photo4 = UIImage(named: "dropsOfJupiter")
        let wine4 = Wine(name: "Drops of Jupiter", photo: photo4, rating: 4)!


        wines = [wine1, wine2, wine3, wine4]

    }
    
    
    // MARK: TableView Datasource & Delegate

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wines.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tblView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WineListTableViewCell
        
        let wine = wines[indexPath.row]
        
        cell.nameLabel.text = wine.name
        cell.wineImageView.image = wine.photo
        cell.ratingControl.rating = wine.rating
        
        return cell
    }
    
    
    
}
