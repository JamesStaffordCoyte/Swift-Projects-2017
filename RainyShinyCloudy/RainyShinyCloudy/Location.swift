//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by James Stafford on 2017-06-28.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import CoreLocation

// Singleton Class to Store Latitude and Longitude
class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
