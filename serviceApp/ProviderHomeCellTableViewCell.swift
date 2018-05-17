//
//  ProviderHomeCellTableViewCell.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/22/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class ProviderHomeCellTableViewCell: UITableViewCell {

    @IBOutlet var locationBtn: UIButton!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud: YBHud!

    @IBOutlet var serviceLbl: UILabel!
    @IBOutlet var daysLbl: UILabel!
    @IBOutlet var nameLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
