//
//  CurrentWeatherModel.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import Foundation
import UIKit



struct CurrentWeatherModel {
    
    let summary : String
    let icon : UIImage
    let temperature : String
    let humidity : String
    let precipitationProbability : String
    
    init(data : CurrentWeather) {
        
        self.summary = data.summary
        self.icon = data.iconImage
        self.precipitationProbability = "%\(data.precipProbability * 100) "
        self.temperature = "\(Int(data.temperature))°"
        self.humidity = "%\(Int(data.humidity*100))"
        
    }
    
    
}
