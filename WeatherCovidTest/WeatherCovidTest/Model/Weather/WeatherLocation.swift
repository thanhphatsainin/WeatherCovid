//
//  WeatherLocation.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import Foundation

struct CityWorld: Codable, Equatable {
    var city: String!
    var lat: String!
    var lon: String!
    var country: String!
    var countryCode: String!
    var adminCity: String!
    var isCurrentLocation: Bool!
}

struct ReadDateCity {
    
    static let shared = ReadDateCity()
    
    private init() { }
    
    //-------------ReadDateCity---------------
    func loadLocationFromCSV() -> [CityWorld] {
        guard let cityPath = Bundle.main.path(forResource: "city", ofType: "csv") else {
            fatalError("Cannot load location.csv file")
        }
        
        var allCityWorld = [CityWorld]()
        let urls =  URL(fileURLWithPath: cityPath)
        do {
            let data = try Data(contentsOf: urls)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArray = dataEncoded?.components(separatedBy: "\n").map({ $0.components(separatedBy: ",")}) {
                var index = 0
                //line must have 6 component ( line.count > 5 )
                for line in dataArray where line.count > 5 {
                    let cityWorld = createLocation(line: line)
                    allCityWorld.append(cityWorld)
                    index += 1
                }
            }
        } catch {
            fatalError("Error reading CSV file")
        }
        return allCityWorld
    }
    
    private func createLocation(line: [String]) -> CityWorld {
        let cityWorld = CityWorld(city: line[0], lat: line[1], lon: line[2], country: line[3], countryCode: line[4], adminCity: line[5], isCurrentLocation: false)
        return cityWorld
    }
}
