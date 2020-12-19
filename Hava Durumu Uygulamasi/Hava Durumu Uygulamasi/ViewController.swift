//
//  ViewController.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblPrecipitation: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var locationManager = CLLocationManager()
   
    let client = DarkSkyApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        self.locationManager.delegate = self
        //uygulama açıldığında kullanıcıdan konum bilgisini paylaşmayı isteyecek
        self.locationManager.requestWhenInUseAuthorization()
        
        
        // konum servisi cihazda açık mı ?
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            //konum bilgisini almaya başlayacak
            locationManager.startUpdatingLocation()
        }
        
    }

    //konum bilgisi değişirse bu kod bloğu çalışır.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("Latitude : \(clientCoordinate.latitude), Longitude : \(clientCoordinate.longitude)")
        updateWeather(coordinate: clientCoordinate)
        
        
    }
    
    
    func updateWeather(coordinate : Coordinate) {
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
            
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
                
            }
            
            
        }
        
        
    }
    
    
    func showWeather(model : CurrentWeatherModel) {
        
        lblSummary.text = model.summary
        lblHumidity.text = model.humidity
        lblTemperature.text = model.temperature
        lblPrecipitation.text = model.precipitationProbability
        weatherIcon.image = model.icon
        indicator.stopAnimating()
    }
    @IBAction func btnefreshClicked(_ sender: UIButton) {
        indicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
        
    }
    
}

