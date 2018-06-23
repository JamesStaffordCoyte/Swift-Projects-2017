//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by James Stafford on 2017-06-28.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

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
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        DispatchQueue.main.async {
            
            var request = URLRequest(url: URL(string: CURRENT_WEATHER_URL)!)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) {data, response, error in
                if error == nil {
                    do {
                        let usableData = data
                        print(usableData!)
                        if let json = try JSONSerialization.jsonObject(with: usableData!) as? Dictionary<String, AnyObject>  {
                            if let name = json["name"] as? String {
                                self._cityName = name
                                print(self._cityName)
                                print(self._date)
                            }
                            if let main = json["main"] as? Dictionary<String, AnyObject> {
                                if let currentTemperature = main["temp"] as? Double {
                                    let kevlinToCelcius = currentTemperature - 273.15
                                    self._temperature = Int(kevlinToCelcius)
                                }
                            }
                            if let weather = json["weather"] as? [Dictionary<String, AnyObject>] {
                                if let main = weather[0]["main"] as? String {
                                    self._weatherType = main
                                }
                            }
                        }
                        completed()
                    } catch  {
                        //
                    }
                }
            }
            dataTask.resume()
        }
        
        
    }
    
    
}
