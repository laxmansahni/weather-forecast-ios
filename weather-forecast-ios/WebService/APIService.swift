//
//  APIService.swift
//  weather-forecast-ios
//
//  Created by Laxman on 16/09/24.
//

import Foundation
import Alamofire

class APIService :  NSObject {

   class func getCurrentWeatherData(city: String, completion : @escaping (_ currentWeather: CurrentWeather?, _ error: Error?) -> ()){
        let parameters: [String: Any] = [
            "key": Constants.strings.apiKey,
            "q": city,
            "aqi": "no",
        ]
        let url = ServiceType.currentWeather.completeUrl
        let request = AF.request(url, parameters: parameters)
        request.responseDecodable(of: CurrentWeather.self) { response in
            
            switch response.result {
                
            case .success(let currentWeather):
                
                completion(currentWeather, nil)
                
            case .failure(let weatherFetcherror):

                completion(nil, weatherFetcherror)
            }
            
        }
    }
    
    
    class func getForecastWeatherData(city: String, completion : @escaping (_ forecastWeather: ForecastDays?, _ error: Error?) -> ()){
        let parameters: [String: Any] = [
            "key": Constants.strings.apiKey,
            "q": city,
            "days": 5,
            "aqi": "no",
            "alerts": "no",
        ]
         let url = ServiceType.forecast.completeUrl
         let request = AF.request(url, parameters: parameters)
         request.responseDecodable(of: ForecastDays.self) { response in
             
             switch response.result {
                 
             case .success(let forecastWeather):
                 
                 completion(forecastWeather, nil)
                 
             case .failure(let weatherFetcherror):

                 completion(nil, weatherFetcherror)
             }
             
         }
     }
}
