//
//  NetworkManager.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation
import CoreLocation

protocol NetworkManagerDelegate: class {
    func updateInteface (_:NetworkManager, with currentWeather: CurrentWeather)
    func updateRain (_:NetworkManager, with currentWeatherRain: CurrentWeatherRain)
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    var currentWeatherData:[CurrentWeather] = []
    
    enum RequestType {
        case cityName(city:String)
        case coordinate(latitude: CLLocationDegrees, longitude:CLLocationDegrees)
    }
    
    func fetchCurrentWeather(forRequestType requestType:RequestType, language:String) {
        var urlString = ""
        switch requestType {
        case .cityName(let city): urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric&lang=\(language)"
        print(urlString)
            
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric&lang=\(language)"
            print(urlString)
        }
        performRequest(withURLString: urlString.encodeUrl)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    if let currentWeather = self.JSONdecoder(withData: data) {
                        self.delegate?.updateInteface(self, with: currentWeather)
                    };
                    if let currentWeatherRain = self.JSONdecoderRain(withData: data) {
                        self.delegate?.updateRain(self, with: currentWeatherRain)
                    };
                }
            }
        }
        task.resume()
    }
    
    func JSONdecoder(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    func JSONdecoderRain(withData data: Data) -> CurrentWeatherRain? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherDataRain = try decoder.decode(WeatherDataRain.self, from: data)
            guard let currentWeatherRain = CurrentWeatherRain(currentWeatherDataRain: currentWeatherDataRain) else { return nil }
            return currentWeatherRain
            
        } catch let error as NSError {
            print(error.localizedDescription)
            print("---NO Rain---")
        }
        return nil
    }
}
extension String{ //URL cyrillic fix
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
