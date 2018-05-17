//
//  costumerDashboardTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/16/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class costumerDashboardTableViewCell: UITableViewCell

{
    
    @IBOutlet var serviceLbl: UILabel!
    
    @IBOutlet var bidCountLbl: UILabel!
    @IBOutlet var infoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
