//
//  Country.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/19/21.
//

import Foundation

struct Country: Decodable {
    let name: String
    let slug: String
    let ios : String

    init() {
        name = ""
        slug = ""
        ios = ""
    }

    init(name : String, slug : String, ios : String) {
        self.name = name
        self.slug = ios
        self.ios = ios
    }

    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case ios  = "ISO2"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        ios  = try container.decode(String.self, forKey: .ios)
    }
}
