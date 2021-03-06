//
//  WeekCell.swift
//  JustWeather
//
//  Created by chetaofeng on 16/6/13.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell {

    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelHighTemp: UILabel!
    @IBOutlet weak var labelLowTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
