//
//  SelectServiceTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class SelectServiceTableViewCell: UITableViewCell {

    @IBOutlet var checkImg: UIImageView!
    @IBOutlet var serviceImg: UIImageView!
    
    @IBOutlet var serviceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
