//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-21.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    private var _date: String! // Today's date
    private var _temperature: Int!
    private var _cityName: String!
    private var _weatherType: String!
    
    
    // Returns today's date
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "\(currentDate)"
        return _date
    }
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var temperature: Int {
        if _temperature == nil {
            _temperature = 0
        }
        
        return _temperature
    }
    
    // Download JSON and Parse
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                    print(self._date)
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kevlinToCelcius = currentTemperature - 273.15
                        self._temperature = Int(kevlinToCelcius)
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main
                    }
                }
            }
            completed()
        }
    }
    
}
