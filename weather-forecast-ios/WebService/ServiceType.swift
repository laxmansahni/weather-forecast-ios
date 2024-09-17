//
//  ServiceType.swift
//  weather-forecast-ios
//
//  Created by ِLaxman on 16/09/24.
//

import Foundation

// MARK: - Header configeration
enum ServiceType: String, CaseIterable {

    // Current Weather
    case currentWeather = "current.json"
    
    case forecast = "forecast.json"
    
    case search = "search.json"
    
}

//MARK:- Derived Propeties
extension ServiceType {
    var name: String {
        return "\(self)".uppercased()
    }
    
    ///This will return complete Url for the Service Type
    var completeUrl: String {
        return Constants.urls.baseUrl + self.rawValue
    }
}



