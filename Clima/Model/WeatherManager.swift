//
//  WeatherManager.swift
//  Clima
//
//  Created by Rasaal Ahmad on 19/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerProtocol {
    func didWeatherUpdate(_ weatherManager:WeatherManager,weatherModel: WeatherModel)
    func didFailedWithError(_ error:Error)
}

struct WeatherManager{
    
    var delegate:WeatherManagerProtocol?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=168fc8e73fc53e6ea07623ec4e06e7bd&units=metric"
    
    func getWeather(_ city:String){
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(urlString)
    }
    
    func getCurrentLocationWeather(_ lon:Float, _ lat:Float)
    {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString)
    }
    
    private func performRequest(_ urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url)  {(data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didWeatherUpdate(self,weatherModel: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeahtherData.self, from: weatherData)
            let weatherModel = WeatherModel(conditionID: decodedData.weather[0].id, city: decodedData.name, temperature: decodedData.main.temp)
            return weatherModel
        } catch{
             print(error)
            self.delegate?.didFailedWithError(error)
            return nil
        }
    }
}
