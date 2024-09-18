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
    var forecastRowItems = BehaviorRelay<[RowViewModel]>(value: [])
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
                self.prepareForecastRowItems(forecastDays: weather.forecast.forecastday)
                self.uiActions.onNext(.reloadForecast)
                self.uiActions.onNext(.showWeather(forecastWeather: weather))
            }
        }
    }

    func prepareForecastRowItems(forecastDays: [Forecastday]) {
        let rowViewModels: [RowViewModel] = forecastDays.map ({ forecastDay in
            return RowViewModel(cellIdentifier: ForecastTableViewCell.identifier, data: forecastDay)
        })
        
        forecastRowItems.accept(rowViewModels)
    }
    
    enum UIActionType {
        case showLoading
        case hideLoading
        case showError(error: Error)
        case reloadForecast
        case showWeather(forecastWeather: ForecastDays)
    }
}
