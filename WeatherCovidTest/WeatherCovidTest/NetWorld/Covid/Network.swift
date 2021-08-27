//
//  Network.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

struct Network {

    static let shared = Network()
    
    private init() { }
    
    private let baseUrl = "https://api.covid19api.com"
    
    func getListCountry() -> String {
        return "\(baseUrl)/countries"
    }
    
    func getCovidGlobal() -> String {
        return "\(baseUrl)/summary"
    }
    
    func getCovidCountry(slug : String) -> String {
        return "\(baseUrl)/dayone/country/\(slug)"
    }
}

enum NetworkError: Error {
    case badURL
}
