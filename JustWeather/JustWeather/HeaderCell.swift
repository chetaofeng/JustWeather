//
//  HeaderCell.swift
//  JustWeather
//
//  Created by chetaofeng on 16/6/13.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelWether: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
