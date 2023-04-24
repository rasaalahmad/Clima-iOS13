//
//  WeatherData.swift
//  Clima
//
//  Created by Rasaal Ahmad on 24/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeahtherData: Decodable {
    let name:String
    let main:Main
    let weather:[Weather]
}

struct Main:Decodable{
    let temp:Float
    let feels_like:Float
    let temp_min:Float
    let temp_max:Float
    let pressure:Int
    let humidity:Int
}

struct Weather:Decodable{
    let id:Int
    let main:String
    let description:String
    let icon:String
}
