//
//  Forecast.swift
//  WeatherApp
//
//  Created by James Stafford on 2017-06-28.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

import Foundation

class Forecast {
    private var _date: String!
    private var _weatherType: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _forecasts = [Forecast]()
    
    var forecasts: [Forecast] {
        return _forecasts
    }
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var minTemp: String{
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String{
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    func downloadForecastDetails(completed: @escaping DownloadComplete)  {
        DispatchQueue.global(qos: .userInteractive).async {
            var request = URLRequest(url: URL(string: FORECAST_URL)!)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) {data, response, error in
                if error == nil {
                    do {
                        let usableData = data
                        print(usableData!)
                        if let json = try JSONSerialization.jsonObject(with: usableData!) as? Dictionary<String, AnyObject> {
                            if let list = json["list"] as? [Dictionary<String, AnyObject>] {
                                for obj in list {
                                    let forecast = Forecast()
                                    var weatherDict = obj
                                    if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
                                        if let min = main["temp_min"] as? Double {
                                            let minKevlinToCelcius = min - 273.15
                                            let intMin = Int(minKevlinToCelcius)
                                            forecast._minTemp = "\(intMin)"
                                        }
                                    }
                                    if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
                                        if let max = main["temp_max"] as? Double {
                                            let maxKevlinToCelcius = max - 273.15
                                            let intMax = Int(maxKevlinToCelcius)
                                            forecast._maxTemp = "\(intMax)"
                                        }
                                    }
                                    if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
                                        if let main = weather[0]["main"] as? String {
                                            forecast._weatherType = main
                                        }
                                    }
                                    if let date = weatherDict["dt"] as? Double {
                                        let unixConvertedDate = Date(timeIntervalSince1970: date)
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateStyle = .full
                                        dateFormatter.dateFormat = "EEEE"
                                        dateFormatter.timeStyle = .none
                                        forecast._date = unixConvertedDate.dayOfTheWeek()
                                    }
                                    if let dateAndTime = weatherDict["dt_txt"] as? String {
                                        let dateFormatter = DateFormatter()
                                        
                                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                        let dateString = dateFormatter.date(from: dateAndTime)
                                        dateFormatter.dateFormat = "ha"
                                        forecast._date = forecast._date + ": \(dateFormatter.string(from: dateString!))"
                                    }
                                    // add to an array
                                    self._forecasts.append(forecast)
                                }
                            }
                        }
                        completed()
                    } catch {
                        
                    }
                }
            }
            dataTask.resume()
            print("finished")
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
