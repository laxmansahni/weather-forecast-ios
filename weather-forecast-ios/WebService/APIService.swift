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
                
                    case .failure(let productFetcherror):
                        
                        print(productFetcherror.localizedDescription)
                completion(nil, productFetcherror)
                    }
            
//            guard let currentWeather = response.value else { return }
//            completion(currentWeather)
        }
    }
}
