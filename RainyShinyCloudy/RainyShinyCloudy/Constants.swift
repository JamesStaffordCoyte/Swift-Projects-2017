//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-21.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation
// URL CONSTANTS
private let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
private let LATITUDE = "lat="
private let LONGITUDE = "&lon="
private let APP_ID = "&appid="
private let API_KEY = "24cd3f155e0060bb7d23858ed0c13d36"

// For GET Requests
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=24cd3f155e0060bb7d23858ed0c13d36"

