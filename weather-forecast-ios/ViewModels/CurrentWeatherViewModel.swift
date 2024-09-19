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
    
    // default City = Dubai
    private let defaultCity = "Dubai"
    private var cityList = [SearchCity]()
    var cityRowItems = BehaviorRelay<[RowViewModel]>(value: [])
    var selectedCity: SearchCity?
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
                self.uiActions.onNext(.showWeather(currentWeather: weather))
            }
        }
    }

    func searchCityData(city: String) {
        if isConnected {
            uiActions.onNext(.showLoading)
            APIService.getSearchCityData(city: city) { (cityList, error) in
                self.uiActions.onNext(.hideLoading)
                guard let cities = cityList else {
                  //show error
                    self.uiActions.onNext(.showError(error: error!))
                    return
                }
                self.cityList = cities
                self.prepareCityRowItems(cityList: cities)
                self.uiActions.onNext(.reloadCities)
            }
        }
    }
    
    func prepareCityRowItems(cityList: [SearchCity]) {
        let rowViewModels: [RowViewModel] = cityList.map ({ city in
            return RowViewModel(cellIdentifier: CityTableViewCell.identifier, data: city)
        })
        
        cityRowItems.accept(rowViewModels)
    }
    
    func handleCityTableSelection(_ indexPath: IndexPath) {
        selectedCity = cityList[indexPath.row]
        guard let city = selectedCity else {
            return
        }
        uiActions.onNext(.showDetailsWeather(city: city))
    }
    
    enum UIActionType {
        case showLoading
        case hideLoading
        case showError(error: Error)
        case reloadCities
        case showWeather(currentWeather: CurrentWeather)
        case showDetailsWeather(city: SearchCity)
    }
}
