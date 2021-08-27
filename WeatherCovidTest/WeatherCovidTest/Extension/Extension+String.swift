//
//  Extension+String.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/20/21.
//

import Foundation

extension String{
    func subStringTime() -> String{
        let news = self[self.index(self.startIndex, offsetBy: 0)...self.index(self.startIndex, offsetBy: 9)]
        return String(news)
    }
}
