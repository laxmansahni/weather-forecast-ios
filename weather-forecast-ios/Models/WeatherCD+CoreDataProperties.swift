//
//  WeatherCD+CoreDataProperties.swift
//  weather-forecast-ios
//
//  Created by Laxman on 17/09/24.
//
//

import Foundation
import CoreData


extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var conditionIcon: String?
    @NSManaged public var conditionText: String?
    @NSManaged public var currentTempC: Double
    @NSManaged public var lat: Double
    @NSManaged public var locationCountry: String?
    @NSManaged public var locationName: String?
    @NSManaged public var locationRegion: String?
    @NSManaged public var lon: Double

}


