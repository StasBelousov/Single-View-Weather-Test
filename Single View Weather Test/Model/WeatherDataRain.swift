//
//  WeatherDataRain.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 29/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

struct WeatherDataRain: Codable {
    var rain: Rain
}
struct Rain: Codable {
    var the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}
