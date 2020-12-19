//
//  DarkSkyApiClient.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import Foundation



class DarkSkyApiClient {
    fileprivate let apiKeyDarkSky = "4cb418bb54aa70da51742e395c441723"
    
    lazy var baseURL : URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKeyDarkSky)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherTypeCompletionHandler = (CurrentWeather? , DarkSkyError?) -> Void
    typealias  WeatherCompletionHandler = (Weather?, DarkSkyError?) -> Void
    private func getWeather(at coordinate : Coordinate, completionHandler completion : @escaping WeatherCompletionHandler) {
     
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, DarkSkyError.invalidURL)
            return
        }
        let requestURL = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: requestURL) { json, error in
            
            guard let json = json else {
                completion(nil, error)
                return
            }
            
            //demek ki elimizde var olan bir json nesnesi var
            
            
            
            guard let weather = Weather(json: json) else {
                completion(nil , DarkSkyError.JSONParsingError)
                return
            }
            
            completion(weather, nil)
        }
        task.resume()
    }
    func getCurrentWeather(at coordinate : Coordinate, completionHandler completion : @escaping CurrentWeatherTypeCompletionHandler) {
        getWeather(at: coordinate) { weather, error in
            completion(weather?.currently,error)
        }
        
    }
    
}
