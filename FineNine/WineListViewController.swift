//
//  WineListViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/21/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit
import Parse

class WineListViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: Properties
    
    var wines = [Wine]()
    var PFWines: [PFWine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //loadSampleWines()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //let query = PFQuery(className: "Wine")
        let queryWine = PFWine.query()
        queryWine!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                PFObject.pinAllInBackground(objects, block: nil)
                
                self.PFWines = objects as? [PFWine] ?? []
                
                do {
                    for w in self.PFWines {
                        let data =  try w.photo?.getData()
                        w.image = UIImage(data: data!, scale: 1.0)
                    }
                } catch {
                    print("err: \(error)")
                }
                
                self.tblView.reloadData()
                
            } else {
                print("Error PFWine fetchAllObjects(): \(error)")
            }
        }
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
        return self.PFWines.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tblView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WineListTableViewCell
        
//        let wine = wines[indexPath.row]
//        
//        cell.nameLabel.text = wine.name
//        cell.wineImageView.image = wine.photo
//        cell.ratingControl.rating = wine.rating
        
        cell.nameLabel!.text = PFWines[indexPath.row].name
        cell.wineImageView?.image = PFWines[indexPath.row].image
        cell.ratingControl.rating = PFWines[indexPath.row].rating
        
        return cell
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueShowDetail" {
            let wineDetailVC = segue.destinationViewController as! WineViewController
            
            if let selectedWineCell = sender as? WineListTableViewCell {
                let indexPath = tblView.indexPathForCell(selectedWineCell)!
                let selectedWine = PFWines[indexPath.row]
                wineDetailVC.pfWine = selectedWine
            }
        }
        else if segue.identifier == "segueAddWine" {
            print("Adding new wine.")
        }
    }
    
    
    @IBAction func unwindToWineList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? WineViewController, wine = sourceViewController.wine {
            
            if let selectedIndexPath = tblView.indexPathForSelectedRow {
                wines[selectedIndexPath.row] = wine
                tblView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndexPath = NSIndexPath(forRow: wines.count, inSection: 0)
                
                wines.append(wine)
                
                tblView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    
    
    
    
    
}
