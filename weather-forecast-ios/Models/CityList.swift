//
//  CityList.swift
//  weather-forecast-ios
//
//  Created by Laxman on 18/09/24.

import Foundation

// MARK: - SearchCity
struct SearchCity: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}

typealias CityList = [SearchCity]
