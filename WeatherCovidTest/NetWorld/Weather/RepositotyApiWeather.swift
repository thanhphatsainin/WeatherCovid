//
//  RepositotyApiWeather.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/21/21.
//

import Foundation


class RepositoryAPIWeather {
    
    func getThoiTietByLocate(lat : Double, lon : Double, completion: @escaping (Result<ThoiTiet, NetworkError>) -> Void){
        APIService.shared.pullJSONData(url: URL(string: NetworkWeather.shared.getThoiTietThanhPhoHienTaiByLocate(lat : lat, lon : lon))) { (result) in
            switch result {
            case .success(let JSONData):
                let weatherData = try? JSONDecoder().decode(ThoiTiet.self, from: JSONData)
                if let weatherData = weatherData{
                    var thoitiet = ThoiTiet()
                    thoitiet.main = weatherData.main
                    thoitiet.weather = weatherData.weather
                    thoitiet.wind = weatherData.wind
                    thoitiet.dt = weatherData.dt
                    thoitiet.sys = weatherData.sys
                    thoitiet.name = weatherData.name
                    completion(.success(thoitiet))
                }
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
    
    func getThoiTiet7Ngay(lat : Double, lon : Double, completion: @escaping (Result<ThoiTiet7Ngay, NetworkError>) -> Void){
        APIService.shared.pullJSONData(url: URL(string: NetworkWeather.shared.getThoiTiet7Day(lat : lat, lon : lon))) { (result) in
            switch result {
            case .success(let JSONData):
                var data : [ListData] = []
                var thoiTiet7Ngay = ThoiTiet7Ngay()
                let response = try! JSONDecoder().decode(ThoiTiet7Ngay.self, from: JSONData)
                for i in response.data {
                    var listData = ListData()
                    listData = i
                    data.append(listData)
                    thoiTiet7Ngay.data = data
                }
                completion(.success(thoiTiet7Ngay))
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
    
    func getThoiTiet3H6Day(lat : Double, lon : Double, completion: @escaping (Result<ThoiTiet3H6Day, NetworkError>) -> Void){
        APIService.shared.pullJSONData(url: URL(string: NetworkWeather.shared.getThoiTietThanhPho3H6Day(lat : lat, lon : lon))) { (result) in
            switch result {
            case .success(let JSONData):
                var list : [Weather2] = []
                var thoiTiet3H6Day = ThoiTiet3H6Day()
                let response = try! JSONDecoder().decode(ThoiTiet3H6Day.self, from: JSONData)
                for i in response.list {
                    var weather2 = Weather2()
                    weather2 = i
                    list.append(weather2)
                    let city = response.city
                    thoiTiet3H6Day.list = list
                    thoiTiet3H6Day.city = city
                }
                completion(.success(thoiTiet3H6Day))
            case .failure(.badURL):
                completion(.failure(.badURL))
            }
        }
    }
}
