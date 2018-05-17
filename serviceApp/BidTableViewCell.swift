//
//  BidTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/10/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class BidTableViewCell: UITableViewCell {

    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var bidCountLbl: UILabel!
    
    @IBOutlet var fImg: UIImageView!
    
    @IBOutlet var sImg: UIImageView!
    
    @IBOutlet var foImg: UIImageView!
    
    @IBOutlet var tImg: UIImageView!
    
    @IBOutlet var fivImg: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
