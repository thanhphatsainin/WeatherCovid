//
//  RepositoryAPI.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

class RepositoryAPI {
    func getListCountry(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        APIService.shared.pullJSONData(url: URL(string: Network.shared.getListCountry())) { (result) in
            switch result {
            case .success(let JSONData):
                var listCountry = [Country]()
                let countryData = try? JSONDecoder().decode([Country].self, from: JSONData)
                if let countryData = countryData {
                    for countryf in countryData {
                        var country = Country()
                        country = countryf
                        listCountry.append(country)
                    }
                    completion(.success(listCountry))
                }
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
    
    func getCovidGlobal(completion: @escaping (Result<GlobalState, NetworkError>) -> Void) {
        APIService.shared.pullJSONData(url: URL(string: Network.shared.getCovidGlobal())) { (result) in
            switch result {
            case .success(let JSONData):
                let globalStateData = try? JSONDecoder().decode(GlobalState.self, from: JSONData)
                if let globalStateData = globalStateData {
                    var globalstate = GlobalState()
                    globalstate = globalStateData
                    completion(.success(globalstate))
                }
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
    
    func getCovidCountry(slug : String, completion: @escaping (Result<[CovidCountry], NetworkError>) -> Void){
        APIService.shared.pullJSONData(url: URL(string: Network.shared.getCovidCountry(slug: slug))) { (result) in
            switch result {
            case .success(let JSONData):
                var listCovidCountry = [CovidCountry]()
                let covidCountryData = try? JSONDecoder().decode([CovidCountry].self, from: JSONData)
                if let covidCountryData = covidCountryData{
                    for covidCountryf in covidCountryData {
                        var covidCountry = CovidCountry()
                        covidCountry = covidCountryf
                        listCovidCountry.append(covidCountry)
                    }
                    completion(.success(listCovidCountry))
                }
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
}
