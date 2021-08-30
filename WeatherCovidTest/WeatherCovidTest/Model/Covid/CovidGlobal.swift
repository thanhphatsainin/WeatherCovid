//
//  CovidGlobal.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

struct GlobalState: Decodable {
    let global : Global
    
    init() {
        global = Global()
    }
    
    init(global : Global) {
        self.global = global
    }
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        global = try container.decode(Global.self, forKey: .global)
    }
}

struct Global: Decodable {
    let totalConfirmed: Int
    let totalDeaths: Int
    let totalRecovered: Int
    
    init() {
        totalConfirmed = 0
        totalDeaths = 0
        totalRecovered = 0
    }
    
    init(totalConfirmed: Int, totalDeaths: Int, totalRecovered: Int) {
        self.totalConfirmed = totalConfirmed
        self.totalDeaths = totalDeaths
        self.totalRecovered = totalRecovered
    }
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered  = "TotalRecovered"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalConfirmed = try container.decode(Int.self, forKey: .totalConfirmed)
        totalDeaths = try container.decode(Int.self, forKey: .totalDeaths)
        totalRecovered  = try container.decode(Int.self, forKey: .totalRecovered)
    }
}
