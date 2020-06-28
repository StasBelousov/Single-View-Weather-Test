//
//  WeatherData.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
    let sys: Sys
    let timezone: Int
    let id: Int
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}
struct Wind: Codable {
    let speed: Int
    let deg: Int
}

struct Weather: Codable {
    let id: Int
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
