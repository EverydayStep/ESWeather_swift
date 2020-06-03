//
//  ESWeather.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/26.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import UIKit

struct ESWeather: Codable {
    var status: String
    var daily_forecast: [ESWeatherValue]
}


struct ESWeatherValue: Codable {
    var cond_code_d: String
    var cond_code_n: String
    var cond_txt_d: String
    var cond_txt_n: String
    var tmp_max: String
    var tmp_min: String
    var date: String
}
