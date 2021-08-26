//
//  SettingTemp.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/23/21.
//

import Foundation

let KEY_TEMP_FORMAT = "TempFormat"
let KEY_MARK_WEATHER = "Markweather"

enum TempFormat:String, CaseIterable {
    case celsius = "Celcius ℃"
    case fahrenheit = "Tempreture ℉"
}
