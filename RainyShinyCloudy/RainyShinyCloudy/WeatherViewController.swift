//
//  WeatherViewController.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-13.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Current weather instance
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        } else {
            locationAuthStatus()
        }
        
        locationManager.startMonitoringSignificantLocationChanges()
        locationAuthStatus()
        
        // Instantiate our current weather and forecast classes
        currentWeather = CurrentWeather()
        forecast = Forecast()
        
        // Download the Current Weather Data in our Model
        currentWeather.downloadWeatherDetails {
            self.updateUI()
        }
        
        // Download the Forecast Data in our Model
        forecast.downloadForecastDetails {
            self.forecasts = self.forecast.forecasts
            self.tableView.reloadData()
        }
       
    }
    
    // Get the latitude and longitude of the user
    func locationAuthStatus() {
        currentLocation = locationManager.location
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        
    }
    
    // Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell {
            let forecastCell = forecasts[indexPath.row]
            cell.updateCell(forecast: forecastCell)
            return cell
        } else {
            return ForecastCell()
        }
    }
    
    func updateUI() {
        cityLabel.text = currentWeather.cityName
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.temperature)°"
        weatherTypeLabel.text = currentWeather.weatherType
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        if currentWeather.weatherType == "Mist" {
            weatherImage.image = UIImage(named: "Rain")
        }
        
    }
    
}

