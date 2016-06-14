//
//  WeatherTableViewController.swift
//  JustWeather
//
//  Created by chetaofeng on 16/6/13.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var sectionTitles = ["","一周天气预报","天气简报","其他数据"]
    var results:[Result] = []
    var result:[Result] = []    //当天天气
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //注册xib
        tableView.registerNib(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        tableView.registerNib(UINib(nibName: "BriefCell", bundle: nil), forCellReuseIdentifier: "briefCell")
        tableView.registerNib(UINib(nibName: "WeekCell", bundle: nil), forCellReuseIdentifier: "weekCell")
        tableView.registerNib(UINib(nibName: "AttachCell", bundle: nil), forCellReuseIdentifier: "attachCell")
        
        //北京的天气周报
        let weeklyWeatherOfBJ = NetworkHelper.weeklyWeather(cityID: "1") //北京id为1
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true //显示菊花显示条
        weeklyWeatherOfBJ.getWeather { (tmpResults, error) in
            if let results = tmpResults {
                self.results = results
                self.result.append(results.first!)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.tableView.reloadData()
                })
            }else{
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    let alertVC = UIAlertController(title: "网络错误", message: error, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
                    alertVC.addAction(okAction)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                })
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false //隐藏菊花显示条
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        switch section {
        case 1:
            count = results.count
        default:
            count = result.count
        }
        return count
    }
    
    //区块标题
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weather = results[0]
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("headerCell",forIndexPath: indexPath) as! HeaderCell
            cell.labelCity.text = weather.citynm
            cell.labelTemp.text = weather.tempHigh + "℃"
            cell.labelWether.text = weather.weather
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("weekCell",forIndexPath: indexPath) as! WeekCell
            let result = results[indexPath.row]
            if indexPath.row == 0 {
                cell.labelToday.text  = "今天"
            }else{
                cell.labelToday.text = ""
            }
            cell.labelWeek.text =  result.week
            let data = NSData(contentsOfURL: NSURL(string: result.weatherIcon)!)!
            cell.imageViewWeather.image = UIImage(data: data)
            cell.labelHighTemp.text = result.tempHigh + "℃"
            cell.labelLowTemp.text = result.tempLow + "℃"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("briefCell",forIndexPath: indexPath) as! BriefCell
            cell.labelBrief.text = "\(weather.weather).最高温:\(weather.tempHigh)℃,最低温:\(weather.tempLow)℃"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("attachCell",forIndexPath: indexPath) as! AttachCell
            cell.labelWind.text = weather.wind
            cell.labelHumid.text = weather.humidity
            return cell
        default:
            return UITableViewCell(frame: CGRectZero)   //返回空cell
        }
    }
    
    //设置行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 3:
            return 88
        default:
            return 45
        }
    }

}
