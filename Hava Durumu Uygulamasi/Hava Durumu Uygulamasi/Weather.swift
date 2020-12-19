//
//  Weather.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import Foundation


struct Weather {
    let currently : CurrentWeather
}

extension Weather {
    
    init?(json : [String : AnyObject]) {
        
        guard let currentWeatherJson = json["currently"] as? [String : AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJson) else {
            return nil
        }
        self.currently = currentWeather
        
    }
    
}
