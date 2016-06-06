//
//  NetworkHelper.swift
//  JustWeather
//
//  Created by chetaofeng on 16/6/2.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import Foundation
import Just

enum NetworkHelper {
    // http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    
    case weeklyWeather(cityID:String)
    
    static var params = [
        "app":"weather.future",
        "appkey":"10003",
        "sign":"b59bc3ef6191eb9f747dd4e83c99f2a4",
        "format":"json"
    ]
    
    static let baseUrl = "http://api.k780.com:88/"
    
    func getWeather(completion:([Result]?,String?) -> Void) {
        var error:String?
        var results:[Result]?
        switch self {
        case .weeklyWeather(cityID: let weaid): //模式匹配方式
            NetworkHelper.params["weaid"] = weaid
            Just.get(NetworkHelper.baseUrl, params: NetworkHelper.params,asyncCompletionHandler: { (request) in
                if request.ok {
                    //确保返回结果为json，且可以转换成字典
                    guard let jsonDics = request.json as? NSDictionary else {
                        error = "不是一个json字符串"
                        return
                    }
                    
                    //确保字典中的success为1
                    guard let success = jsonDics["success"] where success as? String == "1" else{
                        error = "返回数据格式不对，或授权错误"
                        return
                    }
                    
                    let weather = Weather(fromDictionary: jsonDics)
                    results = weather.result
                }else{
                    error = "服务器出错"
                }
                
                completion(results,error)
            })
        default:
            break
        }
    }
}