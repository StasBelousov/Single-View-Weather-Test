//
//  CurrentWeather.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature) + "°"
    }
    var temperatureFahrenheit:Int {
        return (9/5)*(Int(temperature))+32
    }
    var temperatureFahrenheitString: String {
        return String(temperatureFahrenheit) + "°"
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    let description: String
    let id: Int
    var idString: String {
        return String(id)
    }
    let humidity: Int
    var humidityString: String {
        return String(humidity) + " %"
    }
    let pressureH2O: Int
    var pressureHgString: String {
        return String(Int((Double(pressureH2O))/13.595098063*10)) + " мм. рт. ст."
    }
    let windSpeed: Int
    var windSpeedString: String {
        return String(windSpeed) + " м/с, "
    }
    let windDegree: Int
    var windDegreeString: String {
        switch windDegree {
        case 0...44: return "северный"
        case 45...134: return "восточный"
        case 135...224: return "южный"
        case 225...314: return "западный"
        case 315...360: return "северный"
        default: return "-"
        }
    }
    var rain: String {
        switch conditionCode {
        case 200...232: return "100%"
        case 300...321: return "80%"
        case 500...531: return "70%"
        case 600...622: return "100%"
        case 701...781: return "20%"
        case 800: return "0%"
        case 801...804: return "10%"
        default: return "-"
        }
    }
    
    init? (currentWeatherData: WeatherData) {
        
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        conditionCode = currentWeatherData.weather.first!.id
        description = currentWeatherData.weather.first!.weatherDescription
        id = currentWeatherData.id
        humidity = currentWeatherData.main.humidity
        pressureH2O = currentWeatherData.main.pressure
        windSpeed = currentWeatherData.wind.speed
        windDegree = currentWeatherData.wind.deg
    }
    
}
