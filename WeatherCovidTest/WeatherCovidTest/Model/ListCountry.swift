//
//  ListCountry.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

struct Country: Decodable {
    private let name: String
    private let slug: String
    private let ios : String

    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case ios  = "IOS2"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        ios  = try container.decode(String.self, forKey: .ios)
    }
}
