//
//  Service.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 04/03/24.
//

import Foundation

class Service {
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall"
    private let apiKey: String = "YOUR API KEY HERE - OPENWEATHER"
    
    private let session = URLSession.shared
    
    func fetchData(city: City, _ completion: @escaping (ForecastResponse?) -> Void) {
        let urlString = "\(baseURL)?lat=\(city.lat)&long=\(city.long)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL informed")
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data else {
                print("Error - Unvaliable Data")
                completion(nil)
                return
            }
            
            do {
                let forecastResponse: ForecastResponse? = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
