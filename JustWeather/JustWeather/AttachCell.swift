//
//  AttachCell.swift
//  JustWeather
//
//  Created by chetaofeng on 16/6/13.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class AttachCell: UITableViewCell {
    
    @IBOutlet weak var labelHumid: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
