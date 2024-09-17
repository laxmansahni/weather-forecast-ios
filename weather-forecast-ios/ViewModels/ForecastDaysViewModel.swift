//
//  ForecastDaysViewModel.swift
//  weather-forecast-ios
//
//  Created by Laxman on 17/09/24.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class ForecastDaysViewModel {
    
    // default City = Dubai
    private let defaultCity = "Dubai"

    var uiActions = PublishSubject<UIActionType>()
    
    public var isConnected: Bool = false

    
    func getWeatherData() {
        if isConnected {
            uiActions.onNext(.showLoading)
            APIService.getForecastWeatherData(city: defaultCity) { (forecastWeather, error) in
                self.uiActions.onNext(.hideLoading)
                guard let weather = forecastWeather else {
                  //show error
                    self.uiActions.onNext(.showError(error: error!))
                    return
                }
                self.uiActions.onNext(.showWeather(forecastWeather: weather))
            }
        }
    }

    enum UIActionType {
        case showLoading
        case hideLoading
        case showError(error: Error)
        case showWeather(forecastWeather: ForecastDays)
    }
}
