//
//  ForecastCell.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-28.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    
    // Forecast Cell IBOutlets
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastDateLabel: UILabel!
    @IBOutlet weak var forecastWeatherTypeLabel: UILabel!
    @IBOutlet weak var forecastMaxLabel: UILabel!
    @IBOutlet weak var forecastMinLabel: UILabel!
    
    func updateCell(forecast: Forecast) {
        forecastWeatherTypeLabel.text = forecast.weatherType
        forecastMaxLabel.text = forecast.maxTemp + "°"
        forecastMinLabel.text = forecast.minTemp + "°"
        forecastImage.image = UIImage(named: forecast.weatherType)
        forecastDateLabel.text = forecast.date
        
    }
    
    
    
    
    
    
}
