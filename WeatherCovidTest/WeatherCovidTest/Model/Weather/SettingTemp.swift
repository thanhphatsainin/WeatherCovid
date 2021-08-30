//
//  SettingTemp.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/23/21.
//

import Foundation

let KEYTEMPFORMAT = "TempFormat"
let KEYMARKWEATHER = "Markweather"

enum TempFormat:String, CaseIterable {
    case celsius = "Celcius ℃"
    case fahrenheit = "Tempreture ℉"
}
