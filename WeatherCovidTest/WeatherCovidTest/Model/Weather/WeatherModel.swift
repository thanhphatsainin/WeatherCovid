//
//  WeatherModel.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import Foundation

//---- thoi tiet trong ngay -----
struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
    
    init(id : Int, main : String, description : String, icon : String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
    
    func toString() {
        print(self.id,self.main, self.description, self.icon)
    }
}

struct Main : Codable {
    let temp : Double
    let humidity : Double
    
    init() {
        temp = 0
        humidity = 0
    }
    
    init(temp : Double, humidity : Double) {
        self.temp = temp
        self.humidity = humidity
    }
    
    
    func toString() {
        print(self.temp, self.humidity)
    }
    
}

struct Wind : Codable {
    let speed : Double
    
    init() {
        speed = 0
    }
    
    init(speed : Double) {
        self.speed = speed
    }
    
    func toString() {
        print(self.speed)
    }
    
}

struct Sys : Codable {
    let country : String
    
    init() {
        country = ""
    }
    
    init(country : String) {
        self.country = country
    }
    
    func toString() {
        print(self.country)
    }
}


struct ThoiTiet : Codable {
    var weather : [Weather]
    var main : Main
    var wind : Wind
    var dt : CLong
    var sys : Sys
    var name : String
    
    init() {
        weather = []
        main = Main()
        wind = Wind()
        dt = 0
        sys = Sys()
        name = ""
    }

    init(weather : [Weather], main : Main, wind : Wind, dt : CLong, sys : Sys, name : String) {
        self.weather = weather
        self.main = main
        self.wind = wind
        self.dt = dt
        self.sys = sys
        self.name = name
    }
    
}

//-----------------------------


// -------Thoi tiet 3h goi 1 lan, tong 6 ngay----------
struct ThoiTiet3H6Day: Decodable {
    var list: [Weather2]
    var city : City
    
    init() {
        list = []
        city = City()
    }
}

struct City : Decodable {
    let name : String
    let country : String
    
    init() {
        name = ""
        country = ""
    }
}

// (k su dung cai thoi tiet 1 ngay dc vi da thay doi 1 so cai)
struct Weather2: Decodable {
    var weather : [Weather]
    var main : Main
    var wind : Wind
    var dt : CLong
    
    init() {
        weather = []
        main = Main()
        wind = Wind()
        dt = 0
    }
}

//----------------//



//---------------Thoi tiet 7 ngay-------

struct ThoiTiet7Ngay : Codable{
    var data : [ListData]
    
    init() {
        data = [ListData]()
    }
    
    init(data : [ListData]){
        self.data = data
    }
}

struct ListData : Codable{
    var ts : CLong
    var weather : Weather7ngay
    var temp : Double
    
    init() {
        ts = 0
        weather = Weather7ngay()
        temp = 0
    }
    
    init(ts : CLong, weather : Weather7ngay, temp : Double){
        self.ts = ts
        self.weather = weather
        self.temp = temp
    }
}

struct Weather7ngay : Codable {
    let icon : String
    let code : Int
    let description : String
    
    init() {
        icon = ""
        code = 0
        description = ""
    }
    
    init(icon : String, code : Int, description : String) {
        self.icon = icon
        self.code = code
        self.description = description
    }
}

//---------------

