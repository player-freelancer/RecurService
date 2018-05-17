//
//  NotificationTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 1/16/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell
{
    @IBOutlet var sideImg: UIImageView!
    
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var agoLbl: UILabel!
    @IBOutlet var secondLbl: UILabel!
    @IBOutlet var firstLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
