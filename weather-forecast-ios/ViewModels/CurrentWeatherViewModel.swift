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

class CurrentWeatherViewModel {
    
    var currentWeather: CurrentWeather?
    
    // default City = Dubai
    private let defaultCity = "Dubai"

    var uiActions = PublishSubject<UIActionType>()
    
    public var isConnected: Bool = false

    
    func getWeatherData() {
        if isConnected {
            uiActions.onNext(.showLoading)
            APIService.getCurrentWeatherData(city: defaultCity) { (currentWeather, error) in
                self.uiActions.onNext(.hideLoading)
                guard let weather = currentWeather else {
                  //show error
                    self.uiActions.onNext(.showError(error: error!))
                    return
                }
                
                self.currentWeather = weather
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
