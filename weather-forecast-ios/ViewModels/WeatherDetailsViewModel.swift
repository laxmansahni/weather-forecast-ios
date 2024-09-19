//
//  CurrentWeatherViewModel.swift
//  weather-forecast-ios
//
//  Created by Laxman on 17/09/24.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class WeatherDetailsViewModel {
    
    // default City = Dubai
    var uiActions = PublishSubject<UIActionType>()
    var city: SearchCity
    
    public var isConnected: Bool = false
    
    init(city: SearchCity) {
        self.city = city
    }
    
    func getWeatherData() {
        if isConnected {
            uiActions.onNext(.showLoading)
            APIService.getCurrentWeatherData(city: "\(city.lat),\(city.lon)") { (currentWeather, error) in
                self.uiActions.onNext(.hideLoading)
                guard let weather = currentWeather else {
                  //show error
                    self.uiActions.onNext(.showError(error: error!))
                    return
                }
                self.uiActions.onNext(.showWeather(currentWeather: weather))
            }
        }
    }

    enum UIActionType {
        case showLoading
        case hideLoading
        case showError(error: Error)
        case showWeather(currentWeather: CurrentWeather)
    }
}
