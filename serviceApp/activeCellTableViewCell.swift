//
//  activeCellTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/14/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class activeCellTableViewCell: UITableViewCell
{

    @IBOutlet var serviveNmae: UILabel!
    
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var shortImg: UIImageView!
    @IBOutlet var mainImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
