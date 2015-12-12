//
//  BackTableViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/11/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import Foundation

class BackTableViewController: UITableViewController {

    var tableArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableArray = ["Home", "Dino Nug", "Vineyards", "Wines", "Settings"]
        
    }

   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.tableArray[indexPath.row]
        
        return cell
    }

    
    // MARK: - Navigation

    
    
    
    

}
