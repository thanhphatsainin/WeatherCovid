//
//  APIServiceWeather.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import Foundation

class APIServiceWeather {
    private init() {}
    
    static let shared = APIServiceWeather()
    
    func pullJSONData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void){
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error : HTTP Response Code Error")
                return
            }
            
            guard let data = data else {
                print("Error : No Response")
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
