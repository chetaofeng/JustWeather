//
//	Swift.swift
//
//	Create by 涛锋 车 on 2/6/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class Weather{

	var result : [Result]!
	var success : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		result = [Result]()
		if let resultArray = dictionary["result"] as? [NSDictionary]{
			for dic in resultArray{
				let value = Result(fromDictionary: dic)
				result.append(value)
			}
		}
		success = dictionary["success"] as? String
	}
}