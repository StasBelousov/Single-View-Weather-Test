//
//  CurrentWeatherRain.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

struct CurrentWeatherRain {
    
    var rain: Double
    var rainString:String {
        return String(format: "%.0f", rain) + "%"
    }
    
    init? (currentWeatherDataRain: WeatherDataRain) {
        rain = currentWeatherDataRain.rain.the1H
    }
}
