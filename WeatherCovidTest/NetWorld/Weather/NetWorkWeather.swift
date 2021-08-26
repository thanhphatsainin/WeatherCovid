//
//  NetWorkWeather.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import Foundation


struct NetworkWeather {

    static let shared = NetworkWeather()
    
    private init() { }
    
    private let baseUrl = "http://api.openweathermap.org/data/2.5"
    
    
    func getThoiTietThanhPhoHienTaiByLocate(lat : Double, lon : Double) -> String {
        return "\(baseUrl)/weather?lat=\(lat)&lon=\(lon)&appid=5667e18f3836363f6926165a15043cc5"
    }
    
    func getThoiTiet7Day(lat : Double, lon : Double) -> String{
        return "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(lat)&lon=\(lon)&key=ca313af990e94174bab2912d60a680ce&days=7"
    }
    
    func getThoiTietThanhPho3H6Day(lat : Double, lon : Double) -> String {
        return "\(baseUrl)/forecast?lat=\(lat)&lon=\(lon)&appid=5667e18f3836363f6926165a15043cc5"
    }
    
}

