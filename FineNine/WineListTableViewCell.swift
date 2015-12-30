//
//  WineListTableViewCell.swift
//  FineNine
//
//  Created by Robert Rock on 12/21/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit

class WineListTableViewCell: UITableViewCell {

    //==========================================================================================================================
    // MARK: Properties
    //==========================================================================================================================

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var sweetnessRatingControl: SweetnessRatingControl!
    
    
    //==========================================================================================================================
    // MARK: Lifecycle
    //==========================================================================================================================

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
