//
//  CovidCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

struct CovidCountry: Decodable {
    let country: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
//    private let date : Date
    let date: String
    
    init() {
        country = ""
        confirmed = 0
        deaths = 0
        recovered = 0
        active = 0
//        date = Date()
        date = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        country = try container.decode(String.self, forKey: .country)
        confirmed = try container.decode(Int.self, forKey: .confirmed)
        deaths = try container.decode(Int.self, forKey: .deaths)
        recovered = try container.decode(Int.self, forKey: .recovered)
        active = try container.decode(Int.self, forKey: .active)
//        date = try container.decode(Date.self, forKey: .date)
        date = try container.decode(String.self, forKey: .date)
    }
}
